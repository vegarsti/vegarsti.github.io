---
layout: default
title: Vegard Stikbakke
---

# Vegard Stikbakke

I'm a master's student in statistics ([Modelling and Data Analysis](http://www.uio.no/english/studies/programmes/modelling-data-analysis/)) at the University of Oslo. I'm currently doing a research thesis focusing on applications of the statistical machine-learning framework of [boosting](https://en.wikipedia.org/wiki/Boosting_(machine_learning)).

## Links

<!-- Hacky HTML to get list of links with images and decent placement -->
<div id="links">
    <ul>
        <li>
            <i class="fa fa-github" aria-hidden="true"></i>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="https://github.com/vegarsti">GitHub</a>
        </li>
        <li>
            <i class="fa fa-linkedin" aria-hidden="true"></i>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="https://no.linkedin.com/in/vegardstikbakke">LinkedIn</a>
        </li>
        <li>
            <i class="fa fa-envelope-o" aria-hidden="true"></i>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="mailto:vegard.stikbakke@gmail.com">E-mail</a>
        </li>
        <li>
            <i class="fa fa-file-pdf-o" aria-hidden="true"></i>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

## Blog

<!-- {% for post in site.posts limit: 3 %}
- `{{ post.date | date: "%Y-%m-%d" }} - ` [{{ post.title }}]({{ post.url }}) {% endfor %} -->

<div id="blog-links">
{% for post in site.posts limit: 3 %}
<div class="blog-link">
<a href="{{ post.url }}">{{ post.title }}</a>
<br />{{ post.date | date: "%B %-d, %Y" }}
</div>
{% endfor %}
</div>

## Projects

- [`csvprint`](http://github.com/vegarsti/csvprint)