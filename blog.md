---
layout: blog
title: Vegard Stikbakke | Blog
permalink: /blog/
---

{% for post in site.posts %}
<div style="margin-bottom: 10px;">
<a href="{{ post.url }}">{{ post.title }}</a>
<br />{{ post.date | date: "%B %-d, %Y" }}
</div>
{% endfor %}