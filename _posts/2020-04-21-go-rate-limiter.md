---
layout: post
title: Learning Go by writing a rate limiter
---

I've recently been lucky enough to be able to learn some Go at work, while actually solving a problem that we needed to solve.
I thought I would write down some things I learned from it.
While learning this I found the wonderful site [gobyexample.com](gobyexample.com), by [Mark McGranaghan](https://markmcgranaghan.com), extremely useful.
I have sprinkled this blog post with links to respective pages on gobyexample.com.

### Problem
Let's say we need to write a rate limiter.
For our purposes, a rate limiter is a service that only allows a certain amount of incoming traffic to pass.
To be a bit more concrete, let's say that the incoming traffic consist of files to processed, and we want to allow `N` files per second.
For simplicity, let's say that `N` is 2.
Normally, rate limiting means simply ignoring or discarding the traffic above the threshold of allowed traffic.
However, these requests are files that are submitted for processing, so we can't simply ignore them.
But we do want to somehow prioritize these less.
We could, for example, send the remaining traffic to a lower priority version of the service.

The most important thing for this service is to be able to do a lot of concurrent requests.
While the rest of our pipeline is in Python, the current implementation is not able to have the necessary level of concurrency.
We therefore decided to write this service in Go.
Go has [goroutines](https://gobyexample.com/goroutines), which are _lightweight threads of execution_.

### False start
Initially I thought that I could keep a counter for the number of requests.
When a new request got in, I would check if the current count was above or below the given allowed level.
If it was below, it would go straight through.
If it was above, it would go to the low-priority queue.

Since the service needs to run many threads at the same time, I needed a concurrency-safe counter.
This was straightforward using [atomic counters](https://gobyexample.com/atomic-counters).
I also needed a way to find the traffic within a time interval - the latest minute, say.
Although this surely is doable, I couldn't figure out how do to it.

### Eureka
Luckily, Go has channels.
One of Go's mottos is 

> [Share memory by communicating, don't communicate by sharing memory](https://github.com/golang/go/wiki/MutexOrChannel)

It turns out what we want to achieve can be done quite elegantly in Go, using [channels](https://gobyexample.com/channels)..
Using a channel, we can send and receive values.
Multiple goroutines can use the same channel.
It eliminates the need for any synchronization or locking on our side.
The synchronization happens automatically using the channel.
Channels [are the pipes that connect concurrent goroutines](https://gobyexample.com/channels).

### Channels
Here's an example of using a channel.

```go
// channels.go
package main

import "fmt"

func sendMessage(messages chan<- string) {
	messages <- "ping"
}

func main() {
	messages := make(chan string)
	go sendMessage(messages)
	msg := <-messages
	fmt.Println(msg)
}

```
What's happening here is:

1. We make a channel,
2. We send a message to the channel by calling a function as a goroutine.
(If we call a function with `go` in front, the code will run as a goroutine.)
3. We then receive the message from the channel, assign it to a variable, and finally print the message.

So when we run this, using `go run channels.go`, we get `ping` back.

By default a channel is unbuffered, meaning it is synchronized.
This means that a value must be received from the channel at the same time as it's being sent.
We can verify this by calling `sendMessage()` directly instead of as a goroutine.
If we do that, the program crashes!

### Channels with buffering

It's also possible to buffer a channel with multiple values.
We do this by adding a number to the `make` call when we create a channel.
In our case, since we want to allow 2 requests per second, we can create a channel that has a buffer of 2 values.
Then the channel can be received from twice at the same time.

```go
// buffering.go
package main

import "fmt"

func main() {
	messages := make(chan int, 2)
	messages <- 1
	messages <- 2
	fmt.Println(<-messages)
	fmt.Println(<-messages)
}
```

When we run this, using `go run buffering.go`, we get

```
> go run buffering.go
1
2
```

Had we tried to get a third value, our program would crash.
Note here that it was not a problem that we sent messages to the channel directly, we didn't have to do it in a goroutine.

### Tickers

Go has a nice thing called a [Ticker](https://gobyexample.com/tickers), which will trigger with a specified interval duration.
Since we want to allow 2 requests per second, we can make it trigger each half second.
We can use this to send messages to the channel every half second, see `sendTick()` below.
In the main program, we can start an infinite loop that listens to the channel, see `receive()` below.
In the loop that listens to the channel, we can again call some other function, see `doSomething()`.
The sum of this means that the `doSomething` function will be called every 0.5 seconds.

```go
// ticker.go
package main

import (
	"fmt"
	"time"
)

func sendTick(rateLimiter chan<- bool) {
	rate := time.Tick(time.Second / 2)
	for range rate {
		rateLimiter <- true
	}
}

func doSomething() {
	fmt.Println(time.Now())
}

func receive(rateLimiter <-chan bool) {
	for {
		<-rateLimiter
		doSomething()
	}
}

func main() {
	rateLimiter := make(chan bool, 2)
	go sendTick(rateLimiter)
	receive(rateLimiter)
}
```
By running this we can confirm that the function is indeed called twice per second.

```
> go run ticker.go
2020-04-17 07:45:48.748528 +0200 CEST m=+0.501911881
2020-04-17 07:45:49.247683 +0200 CEST m=+1.000288391
2020-04-17 07:45:49.751633 +0200 CEST m=+1.503497054
2020-04-17 07:45:50.249717 +0200 CEST m=+2.000851900
2020-04-17 07:45:50.754079 +0200 CEST m=+2.504518298
```

We have a rate limiter that will allow 2 requests per second.
We're almost there!
(Notice the arrows on the channel types here! The channel type in `receive` is slightly different from the one in `sendTick`.)

### Using `select` to perform a default action

By default sends and receives on a channel block until both the sender and receiver are ready.
If we create a buffered channel, this isn't the case _when there is spare capacity in the channel_.
But as we saw, the `<-rateLimiter` call blocks until there is a value to be received from the channel.
Let's think about our problem again.
If there is no value to be received from the channel, it means that we have exhausted the high priority queue for the current second.
So if we have got a request, we want to send it to the lower priority queue.

This can be done using a [`select`](https://gobyexample.com/select)!
With a select, it's possible to try receiving from multiple channels at the same time.
It's also possible to do a default action if all channels block.
So we can have an infinite loop that listens to the `rateLimiter` channel with a default action `doSomethingLowPriority`.

```go
// select.go
package main

import (
	"fmt"
	"time"
)

func doSomethingHighPriority() {
	fmt.Println(time.Now())
}

func doSomethingLowPriority() {
	fmt.Println("default action")
}

func sendTick(rateLimiter chan<- bool) {
	rate := time.Tick(time.Second / 2)
	for range rate {
		rateLimiter <- true
	}
}

func receive(rateLimiter <-chan bool) {
	select {
	case <-rateLimiter:
		doSomethingHighPriority()
	default:
		doSomethingLowPriority()
	}
}

func main() {
	rateLimiter := make(chan bool, 2)
	go sendTick(rateLimiter)
	for {
		receive(rateLimiter)
		time.Sleep(time.Second / 5) // Sleep to not perform the default action too much
	}
}
```

Let's run it:

```
> go run select.go
default action
default action
default action
2020-04-17 07:46:24.570028 +0200 CEST m=+0.607015588
default action
2020-04-17 07:46:24.974706 +0200 CEST m=+1.011627616
default action
default action
2020-04-17 07:46:25.586716 +0200 CEST m=+1.623540959
default action
```

We're now able to insert actual useful logic in the `doSomethingLowPriority` and `doSomethingHighPriority` functions, and we're done!