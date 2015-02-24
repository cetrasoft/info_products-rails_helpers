# Modals

## Version 1

### Teachable Concept(s)

* Use a class to represent the structure (parts of the HTML). OOP FTW!

### Noteworthy Features

* In order to use Rails built-in helpers, we need to pass along the "context" (a.k.a. the view) to the new class. 
* We make use of an inner class because the `Modal` class isn't very helpful outside of the context of the `ModalHelper`. We mark it private because it shouldn't be publicly useable. 

## Version 2

### Teachable Concept(s)

* Passing a block for the content section

### Noteworthy Features

* The content of our modal will not always be just a plain old string. If we want to include more complex HTML, we should use a block. 
* To get the content of the block, we need to use `capture`. This will call the block and "capture" its output. We can then use that to pass along to our inner class as we did before. 

## Version 3

### Teachable Concept(s)

* Calling methods on the helper within a block

### Noteworthy Features

* This one is a little more complicated..
* The body and footer are separate sections; we need a way to differentiate between the content of each, all from within the context of the `modal` helper block. 
* You expose public methods on the helper for each section both of which take a block for content. You use `capture` to grab the output, but you must pass the helper to the block itself!

## Further Study