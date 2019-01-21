---
layout: default
title: Vegard Stikbakke
---

# Vegard Stikbakke

I'm an MS student in statistics at the University of Oslo (in Norway). Previously I did a BS in math and computer science. I'm interested in software development, machine learning, and learning new things. On this blog, I'll post things that I've learned recently and that I'm thinking about. It's also an experiment to get me to write more and be less perfectionist about it.

## Blog
<div id="blog-links">
{% assign limit = 3 %}
{% for post in site.posts limit: limit %}
<div class="blog-link">
<a href="{{ post.url }}">{{ post.title }}</a>
<br />{{ post.date | date: "%B %-d, %Y" }}
</div>
{% endfor %}
<ul><li><i class="fa fa-pencil" aria-hidden="true"></i><h3><a href="blog/">All {{ site.posts.size }} blog posts</a></h3></li></ul>
</div>

## Links

<!-- Hacky HTML to get list of links with images and decent placement -->
<div id="links">
    <ul>
        <li>
            <i class="fa fa-github" aria-hidden="true"></i>
            <a href="https://github.com/vegarsti">GitHub</a>
        </li>
        <li>
            <i class="fa fa-linkedin" aria-hidden="true"></i>
            <a href="https://no.linkedin.com/in/vegardstikbakke">LinkedIn</a>
        </li>
        <li>
            <i class="fa fa-envelope-o" aria-hidden="true"></i>
            <code>vegard.stikbakke@gmail.com</code>
        </li>
        <li>
            <i class="fa fa-file-pdf-o" aria-hidden="true"></i>
            <a href="assets/pdf/Resume.pdf">Resume</a>
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

- [Reply-to-sheet](http://reply-to-sheet.com)
- [`csvprint`](http://github.com/vegarsti/csvprint)