---
layout: post
title: Enforcing keyword arguments in Python 3
---

Today I learned that in Python 3, one can enforce the use of keyword arguments in functions!

Consider a function for doing safe division. Several things can go wrong when doing division directly, and therefore we might want to use a function which could handle possible errors. One possible error is that dividing by zero is not allowed. Another is that in Python, division always returns a floating point number, and Python does not support arbitrarily large floating point numbers. Thus one might get an overflow error. We might want to introduce two flags for handling these types of errors in our division function, `ignore_overflow` and `ignore_zero_division`. By default, these should be `False`.

```python
def safe_division(number, divisor, ignore_overflow=False, ignore_zero_division=False):
    try:
        return number / divisor
    except OverflowError:
        if ignore_overflow:
            return 0
        else:
            raise
    except ZeroDivisionError:
        if ignore_zero_division:
            return float('inf')
        else:
            raise
```

Calling this straightforwardly like `safe_division(1, 0, True, False)` is not very readable. We would have to check the actual function body to see what this function call would actually do. We can call it like 

```python
safe_division(1, 0, ignore_overflow=False, ignore_zero_division=True)
```
or even

```python
safe_division(1, 0, ignore_zero_division=True, ignore_overflow=False)
```
(notice how we swapped the order here). However, specifying the keywords is only optional behavior for those calling the function.

A solution for this is to enforce using keyword arguments. This is possible to do in Python 2 by specifying a keyword argument dictionary, typically called `**kwargs`. 

However, in Python 3, there is a simple way to enforce it!

```python
def safe_division(*, number, divisor, ignore_overflow, ignore_zero_division):
    try:
        return number / divisor
    except OverflowError:
        if ignore_overflow:
            return 0
        else:
            raise
    except ZeroDivisionError:
        if ignore_zero_division:
            return float('inf')
        else:
            raise
```
If we now call `safe_division(1, 0, True, False)`, or even `safe_division(1, 0)` we would get an error:

```python-traceback
>>> safe_division(1, 2, True, False)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: safe_division() takes 0 positional arguments but 4 were given
```

We now have to use it like this:

```python-traceback
>>> safe_division(number=10**1000, divisor=3**-100,
ignore_overflow=True, ignore_zero_division=False)
0
```

This makes writing [defensive](https://en.wikipedia.org/wiki/Defensive_programming) Python easier!
