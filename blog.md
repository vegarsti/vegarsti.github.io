---
layout: blog
title: Vegard Stikbakke | Blog
permalink: /blog/
---

{% for post in site.posts %}
<div class="blog-link">
<a href="{{ post.url }}">{{ post.title }}</a>
<br />{{ post.date | date: "%B %-d, %Y" }}
</div>
{% endfor %}

[Subscribe with rss](/feed.xml)
