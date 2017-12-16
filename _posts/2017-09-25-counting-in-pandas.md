---
layout: post
title: "Counting in pandas"
date: 2017-09-25T19:04:11+00:00
---

Given data where you have a column \\(X_1\\), say, dates, and another column \\(X_2\\) of some categorical value. You want to count the number of occurrences of each of these pairs. How do you do this?

<!-- more -->

| Date         | Value |
| :-----------:|------:|
| `2017-09-25` |   1   |
| `2017-09-25` |   0   |
| `2017-09-25` |   0   |
| `2017-09-25` |   1   |
| `2017-09-25` |   2   |
| `2017-09-26` |   0   |
| `2017-09-26` |   1   |
| `2017-09-26` |   0   |
| `2017-09-26` |   1   |

You use `len` (length) as the `aggfunc` in the call to `pivot_table`!

```python
df.pivot_table(index=['Date', 'Value'],
    fill_value=0, aggfunc=len)
```

This gives us:

| Date         | Value | Count |
| :-----------:|------:|------:|
| `2017-09-25` |   0   |   2   |
| `2017-09-25` |   1   |   2   |
| `2017-09-25` |   2   |   1   |
| `2017-09-26` |   0   |   2   |
| `2017-09-26` |   1   |   2   |
| `2017-09-26` |   2   |   0   |