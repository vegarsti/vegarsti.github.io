---
layout: post
title: Helpful Python features
---

This is adapted from a talk/live coding session I did while interning at [Spacemaker](https://spacemaker.ai).

A lot of the programming we do in Python consists of doing stuff with lists and dictionaries. If we squint, we see that most of the things we do are quite common, and the Python library has several helpful functions. In this post, I will cover these features and show some use cases for them:

- The `key` argument to `sort`, `min` and `max`
- Truth checks: `any` and `all`
- `groupby` (from `itertools`)
- `defaultdict` (from `collections`)
- Dictionary lookup with default value

## Sorting

In Python, we can sort lists of numbers by using `sorted(list)`:

```python
numbers = [0, 5, 1, 9, 2, 7]
sorted_numbers = sorted(numbers)
sorted_numbers # [0, 1, 2, 5, 7, 9]
```

### Reverse order
If we want to sort by largest first, we use `reverse=True`:

```python
reverse_numbers = sorted(numbers, reverse=True)
reverse_numbers # [9, 7, 5, 2, 1, 0]
```

### Sorting tuples or lists
If sorting tuples or lists, Python will sort by the first element, then the second element, etc. So

```python
tuples = [(1, 0), (1, 1), (1, 0), (0, 1)]
sorted(tuples) # [(0, 0), (0, 1), (1, 0), (1, 1)]
```

### Telling Python what to sort on
An important feature in Python is that we can specify what to sort on. For numbers, it's pretty straightforward. But for anything else, even letters, it's not really uniquely determined. The default sort on letters will say that `A` is larger than 'z'.

```python
letters = ['b', 'A', 'c', 'D']
sorted_letters = sorted(letters)
sorted_letters # ['A', 'D', 'b', 'c']
```
What if we want to sort a list of letters irrespective of lower or uppercase?
For one letter, we can get the lowercase representation using a function like this

```python
def case_insensitive(letter):
  return letter.lower()
```
We can put this function into the `sorted` function call, and sort with it:

```python
sorted_letters = sorted(letters, key=case_insensitive)
sorted_letters # ['A', 'b', 'c', 'D']
```

Whenever we sort, it's all just numbers underneath. The `key` argument is how we get a numeric value from whatever type the elements in the list have. The argument to `key` must be a _function_ which takes an element in the list and returns a score for this element. So it takes a list, calculates a score for each element, sorts this list of numbers, and then returns the list of elements in the sorted order.

### Interlude: `lambda`
The `lambda` keyword in Python is a way to create an anonymous function, meaning, we don't assign a name to it. This is useful if we want to use a very simple function only once. The syntax of `lambda` is `lambda argument: return_value`, or `lambda (argument1, argument2, ...): return_value`. (It needs parentheses if there is more than one argument.) PS: It's not good Python style to assign a name to a `lambda`. Then you should use `def`!

### Sorting with `key`
Let's say we want to sort a list of buildings. Buildings have several attributes, but let's say we want to sort by its score for something. Using `key` in the `sorted` function as well as a `lambda` function, this becomes:

```python
sorted_buildings = sorted(buildings, key=lambda building: building.score)
```

This `key` function can be a lot more complicated. As long as it's a function that works on an element in the lists and returns a numeric value. If we have a list of objects of the same type, and we want to sort it, no matter in what way, it's probably doable with `key`. Additionally, it will be faster than looping, because the built-in sort functions are definitely optimized.

#### Different use case: Sorting a poker hand
Sorting a poker hand can be done with the following:

```python
sorted(cards, key=lambda card: (card.get_rank(), card.get_suit_numeric()))
```

## `key` in `min` & `max`
This `key` thing can also be used for `max` and `min` calls! So let's say we want to find the facade with the highest score. We might be tempted to do that like this

```python
highest_score = float('-inf') # placeholder for worst possible score
building_with_highest_score = None
for building in buildings:
  if building.score > highest_score:
    building_with_highest_score = building
    highest_score = building.score
```
With a custom `key` argument, we can do this by

```python
building_with_highest_score = max(buildings, key=lambda building: building.score)
```
which is arguably a lot more readable! If we need both the building itself, and the score, we can just say

```python
best_score = building_with_highest_score.score
```
afterwards.

## `any` & `all`

Another thing we do often is do many `if` checks. Let's say we want to see if all vectors in a list are non-zero. We might do that like this

```python
any_vector_zero = False
for vector in vectors:
  if norm(vector) == 0:
    check = True
    break
if any_vector_zero:
  # do stuff
```
Another way to do this is to use `any`:

```python
any_vector_zero = any(norm(vector) == 0 for vector in vectors)
if any_vector_zero:
  # do stuff
```

One way to think of `any` is as a chain of `or` statements: `any` returns `True` if _any_ of the statements sent to it are `True`. If all are `False`, we get `False`.

Similarly, we have `all`, which returns `True` if _all_ statements are `True`. A way to think of this is that it is a chain of `and` statements.

## `groupby`

This is another helpful function. Let's say we have a flat list of facades that we want to get in groups according to the sub building they belong to. So we have a list of objects `Facade` with an attribute `sub_building_id`. One way to do this might be to do

```python
facades_per_sub_building_dict = {}
for facade in facades:
  key = facade.sub_building_id
  if key in facades_per_sub_building:
    facades_per_sub_building_dict[key].append(facade)
  else:
    facades_per_sub_building_dict[key] = [facade]
facades_per_sub_building = facades_per_sub_building_dict.values()
```

`groupby` is a function which groups (consecutive) entries together. So we need to sort first. Then with `groupby`, the above code becomes

```python
from itertools import groupby
sorted_facades = sorted(facades, key=lambda facade: facade.sub_building_id)
grouped_facades = groupby(sorted_facades, key=lambda facade: facade.sub_building_id)
facades_per_sub_building = []
for key, group in grouped_facades:
  facades_per_sub_building.append(list(group))
```
Note that the `key` functionality is necessary here, because we use it to tell `groupby` how to group the objects.

## `defaultdict`

Above we wrote

```python
facades_per_sub_building = {}
for facade in facades:
  key = facade.sub_building_id
  if not key in facades_per_sub_building:
    facades_per_sub_building[key] = []
  facades_per_sub_building[key].append(facade)
facades_per_sub_building = facades_per_sub_building.values()
```
Disregard the fact that we could use `groupby` here.
There is one annoying thing we have to do here, and that is to always check if the key is in the dictionary. If it isn't, we have to make a new list first. We can use `defaultdict` for this.

A `defaultdict` is a dictionary which we tell what to do if there doesn't exist a key: We provide a function to be called. If we try to look up a key that is not in the dictionary, the `defaultdict` will create a new entry in the dictionary with this key, and calls the function we provided in this case.

What we would in this case do is tell it to make a new list. We do this by using `list`, which is a function which takes arguments and puts them in a list. If given no arguments, it gives us an empty list. The code becomes

```python
from collections import defaultdict
facades_per_sub_building = defaultdict(list)
for facade in facades:
  key = facade.sub_building_id
  facades_per_sub_building[key].append(facade)
facades_per_sub_building = facades_per_sub_building.values()
```

## Dictionary lookup with default value

A feature of dictionaries which is not always known is that you can provide a default value. The use case for this is that we're checking if an entry exists in our dictionary with a certain key. If the entry exists, we want to use the value we have stored. If not, however, we want to just use a default value. So instead of

```python
if key not in dictionary:
  value = 'default'
else:
  value = dictionary[key]
```
we can write

```python
value = dictionary.get(key, 'default')
```
