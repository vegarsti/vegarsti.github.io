---
layout: post
title: Learning about iterators and generators in Python
---

Python is a cool language! I might be biased, since that's what I used to learn programming some years ago. It wasn't until recently, though, that I started learning about some more advanced features of the language. One such feature is iterators and generators.

An **iterator** is, [in the words of the official documentation](https://docs.python.org/3/glossary.html#term-iterator), *an object representing a stream of data*. An iterator is something you can call `next` on to get the next item. This is what happens in a `for` loop from one iteration to the next.

The typical things we do `for` loops on include lists and strings. These are not iterators, but **iterables**. Again in the words of the [documentation](https://docs.python.org/3/glossary.html#term-iterable), an iterable is *an object capable of returning its members one at a time*. An iterable is not necessarily an iterator. For example,

```python
items = [1, 2, 3]
item = next(a) # TypeError: 'list' object is not an iterator
```
However, if you call `iter` on an _iterable_, you get an _iterator_:

```python
items = [1, 2, 3, 4, 5]       # iterable
iterator_items = iter(items)  # iterator
item = next(iterator_items)
print(item)                   # 1
```
In addition, we have something called **generators**. A generator is a function which returns an iterator. It looks like a regular function, except it uses `yield` instead of `return`. Unfortunately, the term generator is used to mean both the generator function and the generator object.

When a generator _function_ is called, a generator _object_ is created, without executing anything in the function. The generator works in such a way that it starts executing until it reaches the first `yield` statement in the code. Then it returns the value in this statement. The next time `next` is called, the generator continues its execution, _continuing where it left off_, until the next `yield` statement. And so on. This is an example of [lazy evaluation](https://en.wikipedia.org/wiki/Lazy_evaluation).

Let's look at an example of a generator. (Note that `>` means the output we get.)

```python
def a_generator():
    print("before 0")
    yield 0
    print("before hi")
    yield "hi"
    print("last")
    
iterator = a_generator()
item = next(iterator)
> before 0
print(item)                   # 0
item = next(iterator)
> before hi
print(item)                   # hi
next(iterator)
> last
> StopIteration error
```
We see that we called `next` one time too many. This is avoided, however, if we use a `for` to iterate.

```python
iterator = a_generator()
for item in iterator:
    print(item)
> before first
> 0
> after first
> hi
> last
```

Finally, an important thing that the lazy evaluation provides us with is the ability to create infinite iterators.

The iteration framework, and perhaps generators in particular, are powerful tools, and can really help with abstraction, among other things. Ned Batchelder gave a really good talk on this at PyCon 2013. I recommend you [check it out](https://www.youtube.com/watch?v=EnSu9hHGq5o)!
