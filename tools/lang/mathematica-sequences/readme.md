
Working with Sequences
======================

### Elementary Functions ###

Mathematica provides a couple of elementary functions that you can use to create and modify sequences.
You can also use them to build up more complex computations:

* `Nest` let's you apply a function repeatedly: 
  `Nest[f, x, 3]` → `f[f[f[x]]]`
* `NestList` works like `Nest` but it returns a list containing all the intermediate states:
  `NestList[f, x, 3]` → `{x, f[x], f[f[x]], f[f[f[x]]]}`
* `Map` applies a function to every single element of a list: `Map[f, {1, 2, 3}]` →  `{f[1], f[2], f[3]}`
* `Fold` is similar to `Nest` and `Map`, it creates a nested function, like this: 
  `Fold[f, {1, 2, 3}]` →  `f[f[1, 2], 3]`
* `FoldList` works like `Fold` but it returns a list containing all the intermediate states:
  `FoldList[f, x, 3]` → `{1, f[1, 2], f[f[1, 2], 3]}`
	

### Summing Sequences ###

Let's say you want to sum up all the vectors in a list: `list = {{1, 2}, {3, 4}, {5, 6}};`
Most functions like can take multiple arguments.
So to sum up all elements of your list can apply `Plus` to it like this: `Apply[Plus, list]` → `{9, 12}`.
	
Note how the elements are treated like vectors, with the components being added up separatly.
Instead of Apply you can also use the shorthand `@@` like this: `Plus @@ list` → `{9, 12}`.

### Accumulating Sequences ###

You can use the `Fold` to successive add elements of a list.

`Fold[Plus, list]` →  `{9, 12}`

The function `FoldList` will return the same, including all intermediate results.

`FoldList[Plus, list]` →  `{{1, 2}, {4, 6}, {9, 12}}`

There is also a function called `Accumulate` which does the same thing.

`Accumulate[list]` →  `{{1, 2}, {4, 6}, {9, 12}}`

This is a very nice example how you can use the power of lementary functions like `Fold` and `Plus` to achieve your goal. What would you do if you wanted to multipy elements instead of adding them up?


### Splitting and Splicing Sequences ###

`Partition` is a very powerfull operator that lets you split sequences into smaller sequences:
`Partition[{1, 2, 3, 4, 5, 6}, 2]` → `{{1, 2}, {3, 4}, {5, 6}}`

You can also use it to create overlapping subsequences:
`Partition[{1, 2, 3, 4, 5, 6}, 2, 1]`  → `{{1, 2}, {2, 3}, {3, 4}, {4, 5}, {5, 6}}`

To put the sequence back together use `Join`: `Join[{{1, 2}, {3, 4}, {5, 6}}]`  → `{1, 2, 3, 4, 5, 6}`

If you want to zip two sequences `{1, 2, 3}` and `{a, b, c}` taking elements in alternation, you can change their oder using `Transpose`: `Transpose[{{1, 2, 3}, {a, b, c}}]` → `{{1, a}, {2, b}, {3, c}}`.
Now zipping them together is as easy as this:

`Join @@ Transpose[{{1, 2, 3}, {a, b, c}}]` → `{{1, a}, {2, b}, {3, c}}`

Not how we used `@@` to apply the `Join` operator to the list. Can you explain why this is necessary?

Again there is a more specific function called `Riffle` that does exactly the same thing:
`Riffle[{{1, 2, 3}, {a, b, c}}]` → `{{1, a}, {2, b}, {3, c}}`
