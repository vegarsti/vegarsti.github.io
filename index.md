---
layout: default
title: Vegard Stikbakke
---

# Vegard Stikbakke

Some text about how I study statistics at [University of Oslo](http://google.com) and work with data science at [Kolonial.no](http://kolonial.no).

- [GitHub](https://github.com/vegarsti)
- [LinkedIn](https://no.linkedin.com/in/vegardstikbakke)
- [Twitter](https://twitter.com/vegardstikbakke)
- [E-mail](mailto:vegard.stikbakke@gmail.com)
- [Resume](assets/pdf/resume.pdf) (pdf)

## Blog

[All posts](/blog/)
{% for post in site.posts limit: 3 %}
- `{{ post.date | date: "%Y-%m-%d" }} - ` [{{ post.title }}]({{ post.url }}) {% endfor %}

## Projects

- Lorem ipsum
- [`csvprint`](http://github.com/vegarsti/csvprint)