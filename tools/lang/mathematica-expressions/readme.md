Working with Expressions
========================


Remember that everything is an expression in Mathematica.
Let's play around with a really simple expression:

    fn = f[x, y, z]
    
If you want to see a more visual rendering of your expression, try to render it using the `TreeForm`.
You can accomplish this is by adding `// TreeForm` to your input:

    fn // TreeForm
    
### Taking Expressions Apart ###

*You can take an expressions apart using the `Part` function.*

* To get the head of an expression: `Part[fn, 0]` → `f`
* To get the first part: `Part[fn, 1]` → `x`
* To get the last part: `Part[fn, -1]`→ `z`

*A shorthand for the `Part` function is the double bracket notation:*

* To get the head of an expression: `fn[[0]]` → `f`
* To get the first part: `fn[[1]]` → `x`
* To get the last part: `fn[[-1]]`→ `z`

   
*Instead of using those basic functions you can also resort to more specific functions:*

* To get the head of the experssion: `Head[fn]` → `f`
* To get the first part: `First[fn]` → `x`
* To get the last part: `Last[fn]`→ `z`

You can build all of your computations from a very small set of basic functions,
but by resorting to specific function you can make your code a lot easier to read.


### Modifying Expressions ###


You can specify the part you want to modify on the left hand side of an assignment.

* Modify the head like this `Part[fn, 0] = g` → `fn = g[x, y, z]`
* Or like this `fn[[0]] = g` → `g[x, y, z]`
* Modify the first element like this `Part[fn, 1] = 100 ` → `fn = g[100, y, z]`
* Or use the double bracket notation like this: `fn[[1]] = 100 ` -> `fn → g[100, y, z]`

To modify the head of an expression you would can use `Apply`.

* To modify the head of the expression: `Apply[g, fn` → `g[x,y]`
* Or you could use the `@@` shorthand like this: `g @@ fn` → `g[x,y]`

This function is called `Apply` because it can be used to apply a function to the arguments of a list using `Apply[,f {x,y,z}]` → `f[x,y,z]`

You can also replace parts of an experession using the `ReplaceParts` function.
