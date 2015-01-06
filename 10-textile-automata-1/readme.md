Textile Automata
================

## Generating Curves

### Introduction ###

Here are a couple of videos by Numberphile.  
They show how the dragon curfe fractal can be computed, by folding a strip of paper:

* [Unfolding the Dragon-Curve](https://www.youtube.com/watch?v=NajQEiKFom4)
* [Folding the Dragon Curve with Paper](https://www.youtube.com/watch?v=wCyC-K_PnRY)
* [Video of Donald Knuth and his Dragon Curve](https://www.youtube.com/watch?v=v678Em6qyzk)

#### Things to try
* Can you think of similar things you can do with paper folding ?
* How many times can you fold a strip of paper? Why?


### Substitution Systems

Lindenmeyer-Systems are most popular Substitution-System.
An L-System is made up of:

* An **Alphabet**
* An **Axiom**
* A Set of **Rewriting Rules** (Productions)

Example:

    axiom  : A
    rules  : (A → AB), (B → A)
 
This produces:
    
    n = 0 : A
    n = 1 : AB
    n = 2 : ABA
    n = 3 : ABAAB
    n = 4 : ABAABABA

Now if you want to turn this into a physical object you need an **Intepretation**.  
That is something that maps the letters to actions of a turtle, an embroidery machine or anything you can think of.


### Fractal Curves

#### Levy Dragon ####

![](https://web.archive.org/web/20140107102042/http://ecademy.agnesscott.edu/~lriddle/ifs/levy/tapestryOutsideSmall.jpg)

The [Levy-Dragon Embroidery](http://ecademy.agnesscott.edu/~lriddle/ifs/levy/levy.htm) is based on a very simple Substitution System.


