---
layout: post
title: Waiting for dependencies in tests
---

As part of my development workflow, I usually run some integration tests.
An integration test means that code interacts with some outside dependency.
This could be a temporary Postgres server in a Docker container, or it could be an HTTP server.
These dependencies usually take some time to start.
In particular, enough time to start that our tests would fail if we ran them immediately after starting our dependencies.

To make this concrete, let's use [docker-compose](https://docs.docker.com/compose/) to start a Postgres server in a Docker container.
Our `docker-compose.yml` becomes

```yaml
version: "3.8"
services:
  postgres:
    image: postgres:13-alpine
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: admin
      POSTGRES_USER: admin
```

and we can start it by doing `docker-compose up`.

We also want a `Makefile` to perform the whole test, including the setup.
The structure of our `Makefile` is

1. start Docker containers
2. **wait until dependencies are ready**
3. execute tests
4. shut down Docker containers

The lazy way to do step 2 is to wait a set amount of time before executing tests, typically by running the shell command `sleep N`.
To be sure that the dependencies are indeed ready when we start our tests, we will want to set `N` to a safe upper bound on the depency's startup time.
If we run locally, we probably have the Docker containers cached, so `docker-compose up` might not take long.
However, if we run our CI in Github Actions, the containers will not be cached, and so the wait time is longer and more unpredictable.
This means that if we set the time to a comfortable upper bound so we sleep long enough in CI, we risk wasting time each time we run our tests locally.

But there are better solutions!

## `until`

The [`until` shell command](https://linuxcommand.org/lc3_man_pages/untilh.html) will run a command until it succeeds.
Like a `while` loop but with the predicate switched.
If we find a shell command that returns exit code 0 (indicating success) if the dependencies are ready, and not 0 if they are not ready, we can put this inside an `until` loop.

It turns out that the Postgres client `psql` comes with a command called [`pg_isready`](https://www.postgresql.org/docs/13/app-pg-isready.html), which will do just that:
It pings a Postgres server and returns a non-zero exit code if it's not ready.

The complete Makefile becomes

```make
all:
	make test

test:
	docker-compose up -V -d postgres
	until pg_isready --host localhost --port 5432; do \
		sleep 0.1; \
	done
	echo "my test here"
	docker-compose down
```

Try it yourself by cloning [this Github repo](https://github.com/vegarsti/until) and running `make`!

## Bonus: HTTP server

If we want to wait for an HTTP server to be responsive, we can instead run this [`curl`](https://curl.se/) command:

```
curl --output /dev/null --silent --head --fail http://localhost:${PORT}
```

which becomes the following in a Makefile:

```
until $$(curl --output /dev/null --silent --head --fail "http://localhost:8080"); do \
	sleep 0.1; \
done
```

