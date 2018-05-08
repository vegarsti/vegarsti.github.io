---
layout: default
title: Vegard Stikbakke
---

# Vegard Stikbakke

I'm a master's student in statistics ([Modelling and Data Analysis](http://www.uio.no/english/studies/programmes/modelling-data-analysis/)) at the University of Oslo. I'm currently taking machine learning courses and doing research on applying the statistical machine-learning framework of [boosting](https://en.wikipedia.org/wiki/Boosting_(machine_learning)) to [first-hitting-time models](https://en.wikipedia.org/wiki/First-hitting-time_model). I'm interested in software development and machine learning.

## Blog
<!-- <a href="blog/">All {{ site.posts.size }} posts</a> -->
<div id="blog-links">
{% assign limit = 3 %}
{% for post in site.posts limit: limit %}
<div class="blog-link">
<a href="{{ post.url }}">{{ post.title }}</a>
<br />{{ post.date | date: "%B %-d, %Y" }}
</div>
{% endfor %}
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

- [`csvprint`](http://github.com/vegarsti/csvprint)