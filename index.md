---
layout: default
title: Vegard Stikbakke
---

# Vegard Stikbakke

I'm a backend software engineer at [Cognite](https://cognite.com).
I studied statistics, math and computer science at the University of Oslo.
I like to read and learn.

## Links


<table>
  <tr>
    <td><i class="fab fa-github" aria-hidden="true"></i></td>
    <td>&nbsp;<a href="https://github.com/vegarsti">GitHub</a></td> 
  </tr>
  <tr>
    <td><i class="fab fa-twitter" aria-hidden="true"></i></td>
    <td>&nbsp;<a href="https://twitter.com/vegardstikbakke">Twitter</a></td> 
  </tr>
  <tr>
    <td><i class="fab fa-goodreads" aria-hidden="true"></i></td>
    <td>&nbsp;<a href="https://www.goodreads.com/user/show/3400170-vegard-stikbakke">Goodreads</a></td> 
  </tr>
  <tr>
    <td><i class="fab fa-linkedin" aria-hidden="true"></i></td>
    <td>&nbsp;<a href="https://no.linkedin.com/in/vegardstikbakke">LinkedIn</a></td> 
  </tr>
  <tr>
    <td><i class="fas fa-file-alt" aria-hidden="true"></i></td>
    <td>&nbsp;<a href="assets/pdf/Resume.pdf">Resume</a></td> 
  </tr>
  <tr>
    <td><i class="fas fa-envelope" aria-hidden="true"></i></td>
    <td>&nbsp;<code>vegard.stikbakke@gmail.com</code></td> 
  </tr>
</table>


## Posts
<div>
{% assign limit = 4 %}
{% for post in site.posts limit: limit %}
<div>
<a href="{{ post.url }}">{{ post.title }}</a>
<br />{{ post.date | date: "%B %-d, %Y" }}
</div>
<br />
{% endfor %}
<h3><a href="blog/">View all posts</a></h3>
</div>