# Mathematica Files

*Mathematica files come in different formats*

* **Notebooks** (`.nb`)
* **Computable Document Format** (`.cdf`)
* **Mathematica** (`.m`) or **WolframLang** (`.wl`)


## Notebooks

* In *Mathematica* everything is an expression.
* A notebook is an expression defining a document.
* Notebooks contain cached content and history <br> this does not play nicely with version management systems like *git*.

--- 

* **Edit + Run:** in *Mathematica* (Graphical User Interface)
* **Create:** `New > Notebook`

---

### Examples

* [Wolfram Library Archive](http://library.wolfram.com/)



## Computable Document Format

* Notebooks that can be run without Mathematica (*"Executables"*)
* Needs a Plugin (*CDF Player*)
* Interactive Interfaces with `Manipulate`
* License: You can run them anywhere as long as they are *CC-BY-SA*


---

* **Edit:** in Mathematica
* **Run:** in the browser or standalone
* **Create:** `New > Demonstration`

--- 

### Examples

* [Wolfram Demonstrations](http://demonstrations.wolfram.com)

### Docs

* `howto/CreateAComputableDocumentFormatFile`



# Mathematica / WolframLang


* Textfiles containing Mathematica code.
* WolframLang = new name for the Language formerly known as *Mathematica*


---
* **Edit:** in your favourite text edtior
* **Run:** command-line / Wolfram-Kernel / *Mathematica*
* **Create:** `New > Textfile`

---

### Examples

* *[WolframLanguage Code Gallery](http://www.wolfram.com/language/gallery/)*
* *[@WolframTap](https://twitter.com/wolframtap/)*

## Mathematica Packages

* Packages are Mathematica modules that provide functions
* Mathematica comes with a lot of packages
* Special Syntax to add Notebook-like formatting in *Mathematica*
* Conventions for namespaces + docstrings etc.

---

* **Edit:** in your favourite Text Editor / *Mathematica*
* **Create:** `New > Package`

---

### Examples

* Look inside your *Mathematica* Installation!



Exercises
=========

* Create a function to draw [Epicycloids](https://en.wikipedia.org/wiki/Epicycloid)

## 1. Notebooks
* Create a notebook
* Add your function to the notebook
* Turn the cell containing the function into an initialization cell
* Call the function with any parameters you like
* Add some text to explain what's going on.
* Add headlines and make use of the various styles (learn the keyboard shortcuts, you will need them!)

## 2. Wolfram Demonstrations
* Create a demonstration
* Create an interactive version of the hypercycloids with sliders
* Export it as a CDF file and dembed it in a webpage

## 3. *Mathematica* Files
* Locate the initialization file:<br>
  `About Mathematica > System Information > InitializationFiles loaded`
* Add the hypercycloid function to the initialization file
* Restart Mathematica and check if your function has been defined


## 4. *Mathematica* Packages
* Learn more about the default structre of a *Mathematica* package
* Have a look at the packages that come with *Mathematica*
* Find your user folder for *Mathematica* packages (Hint: `$PATH`)
* Clone the current version of *Textilica* package into your package folder
* Create a notebook that loads textilica and uses one of its functions
* Let's create a cycloid package together!


