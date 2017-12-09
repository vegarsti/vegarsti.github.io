---
layout: post
title: Setting up
date: 2017-04-22T13:53:07+00:00
---

In this blog post I describe the steps needed to set up this static blog on a DigitalOcean VPS. I spent a lot of time troubleshooting before I got it to work, so I decided to document the entire process, since I am likely to forget a lot of these small steps. The end result is that I can write blog posts locally in Markdown, push the changes, and then the VPS builds the site.

<!-- more -->

I had previously set up [a website](http://vegardstikbakke.com) on a VPS hosted at DigitalOcean. I created a droplet there and installed a basic LAMP stack on the DigitalOcean VPS, using [this tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04).

### On my local machine
I installed Ruby, along with [Octopress](http://octopress.org), which is a superset (as far as I can tell!) of [Jekyll](https://jekyllrb.com), for quickly generating a skeleton site and hosting a blog.

```bash
gem install octopress --pre
curl -L https://get.rvm.io | bash -s stable --ruby=2.0.0
source /Users/vegard/.rvm/scripts/rvm
gem install jekyll bundler
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
rbenv rehash
```

To create a new skeleton directory, do

```bash
octopress new blog
cd blog
jekyll serve
```

A basic site is now browsable at localhost. To be able to use this as `site/blog`, I had to change `baseurl` to `/blog` in `_config.yml`.

Create a git repository in this directory.

```bash
git init
git add .
git commit -m "Initial commit"
```

### On DigitalOcean
[This tutorial](https://www.digitalocean.com/community/tutorials/how-to-deploy-jekyll-blogs-with-git) gives steps for deploying a Jekyll blog, through Git, to DigitalOcean. However, simply doing these steps was not quite enough to get it to work. So here I will repeat these steps, but with all of the additional steps I needed to get it to work.

Install Ruby and Jekyll (+ bundler) on the VPS.

```bash
curl -L https://get.rvm.io | bash -s stable --ruby=2.0.0
gem install jekyll bundler
```

Then create a Git repo in the home directory.

```bash
cd ~/
mkdir repos
cd repos
mkdir blog.git
cd blog.git
git init --bare
```

The `--bare` creates some additional stuff, which we need to set up a `post-receive` hook.

```bash
cd hooks
touch post-receive
nano post-receive
```

Inside `post-receive`, put

```
#!/bin/bash -l
GIT_REPO=$HOME/repos/blog.git
TMP_GIT_CLONE=$HOME/tmp/git/blog
PUBLIC_WWW=/var/www/html/blog

git clone $GIT_REPO $TMP_GIT_CLONE
jekyll build --source $TMP_GIT_CLONE --destination $PUBLIC_WWW
rm -Rf $TMP_GIT_CLONE
exit
```

Save the file and make it executable by doing `chmod +x post-receive`.

Then make sure `repos` is owned by your user (`vegard` in my case), not `root`. I had to do the steps above using superuser privileges, so I just changed the ownership afterwards, like so:

```bash
sudo chown -R vegard:vegard ~/repos
```

Back on the local machine, do

```bash
git remote add droplet user@example.org:repos/blog.git
```

In my case, I have set up an SSH key, so I did `server` instead of `user@example.org`. Then do `git push droplet master`. Now I can edit my blog locally, and when I'm satisfied, push the changes and they become visible here (remotely).

To add it to a GitHub repository, do

```bash
git remote add github https://github.com/vegarsti/blog.git
```

To push to both repositories with `git pushall` at the same time, create an alias

```bash
git config alias.pushall '!git push droplet && git push github'
```

### Postlude

Afterwards, I decided I didn't like the standard Octopress layout. So I downloaded a theme called [whiteglass](https://github.com/yous/whiteglass), which allows a lot more tinkering, and put that in the `blog` directory instead. The rest of the process is the same, but on the VPS I had to install some packages for Jekyll:

```bash
gem install jekyll-archives jekyll-sitemap jekyll-paginate
```

Thanks for reading!