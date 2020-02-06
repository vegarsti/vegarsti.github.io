---
layout: default
title: Vegard Stikbakke
---

# Vegard Stikbakke

I'm a backend software engineer at [Cognite](https://cognite.com).
I studied statistics, math and computer science at the University of Oslo.
I like to read and learn.

## Links

<!-- Hacky HTML to get list of links with images and decent placement -->
<div id="links">
    <ul>
        <li>
            <i class="fab fa-github" aria-hidden="true"></i>
            <a href="https://github.com/vegarsti">GitHub</a>
        </li>
        <li>
            <i class="fab fa-twitter" aria-hidden="true"></i>
            <a href="https://twitter.com/vegardstikbakke">Twitter</a>
        </li>
        <li>
            <i class="fab fa-goodreads" aria-hidden="true"></i>
            <a href="https://www.goodreads.com/user/show/3400170-vegard-stikbakke">Goodreads</a>
        </li>
        <li>
            <i class="fab fa-linkedin" aria-hidden="true"></i>
            <a href="https://no.linkedin.com/in/vegardstikbakke">LinkedIn</a>
        </li>
        <li>
            <i class="fas fa-file-alt" aria-hidden="true"></i>
            <a href="assets/pdf/Resume.pdf">Resume</a>
        </li>
        <li>
            <i class="fas fa-envelope" aria-hidden="true"></i>
            <code>vegard.stikbakke@gmail.com</code>
        </li>
    </ul>
</div>

## Posts
<div id="blog-links">
{% assign limit = 20 %}
{% for post in site.posts limit: limit %}
<div class="blog-link">
<a href="{{ post.url }}">{{ post.title }}</a>
<br />{{ post.date | date: "%B %-d, %Y" }}
</div>
<br />
{% endfor %}
<h3><a href="blog/">View all posts</a></h3>
</div>