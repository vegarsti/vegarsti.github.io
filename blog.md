---
layout: blog
title: Vegard Stikbakke | Blog
permalink: /blog/
---

{% for post in site.posts %}
- `{{ post.date | date: "%Y-%m-%d" }} - ` [{{ post.title }}]({{ post.url }}) {% endfor %}

[Subscribe with rss](/feed.xml)
