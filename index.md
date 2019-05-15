---
layout: default
title: Vegard Stikbakke
---

# Vegard Stikbakke

I'm a software engineer at [Cognite](https://cognite.com).
I have an MS in statistics and a BS in math and computer science from the University of Oslo, and I've previously worked at several Norwegian companies: [Konsus](https://www.konsus.com), [Spacemaker](https://spacemaker.ai), [Kolonial.no](https://jobb.kolonial.no), and [Bekk Consulting](https://www.bekk.no).
I like using data and software to solve problems.
I also love to read.

## Blog
<div id="blog-links">
{% assign limit = 3 %}
{% for post in site.posts limit: limit %}
<div class="blog-link">
<a href="{{ post.url }}">{{ post.title }}</a>
<br />{{ post.date | date: "%B %-d, %Y" }}
</div>
{% endfor %}
<ul><li><i class="fas fa-pencil-alt" aria-hidden="true"></i><h3><a href="blog/">View all posts</a></h3></li></ul>
</div>

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

<!-- Old list of links
<i class="fa fa-github" aria-hidden="true"></i> [GitHub](https://github.com/vegarsti)
<br /><i class="fa fa-linkedin" aria-hidden="true"></i> [LinkedIn](https://no.linkedin.com/in/vegardstikbakke)
<br /><i class="fa fa-twitter" aria-hidden="true"></i> [Twitter](https://twitter.com/vegardstikbakke)
<br /><i class="fa fa-envelope-o" aria-hidden="true"></i> [E-mail](mailto:vegard.stikbakke@gmail.com)
<br /><i class="fa fa-file-pdf-o" aria-hidden="true"></i> [Resume](assets/pdf/resume.pdf)
-->

## Projects

- [Image-to-table](http://image-to-table.com)
- [`csvprint`](http://github.com/vegarsti/csvprint)