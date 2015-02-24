# Description Lists

## Teachable Concept(s)

* Separate domain/project-specific helpers from generic ones. 
* Build the former on top of the latter
* Build your helpers in a modular way such that you can build larger ones from the smaller ones


## Noteworthy Features

* TBS bug requires that a `<dd>` always have some content. See [this](http://ryanjafari.me/blog/2014/04/01/gotcha-with-html-definition-lists-dls-and-bootstrap-3s-dl-horizontal-class/) blog post
* The `description_list_pair` helper method remains generic: it takes two string values and puts them into the standard `<dl>` structure. It can easily be used across many different projects and probably belongs in the `lib` folder
* The `description_list_pair_for` helper is domain/project-specific. Here is where you can make some more assumptions about how it's being used. Don't expect this to be reusable across other projects. 
* You can keep using the smaller pieces to build bigger, more comprehensive helpers. The modularity of the smaller helpers will ensure that you won't end up with a giant brittle helper that can never be changed. 
* `safe_join` is a nice way to concatenate tags and different parts together. You could use `+` or `<<` or even `Array.join` but you have to remember to call `html_safe` on it. `safe_join` does this for you automatically. 

## Further Study

* A single `<dt>` can have multiple `<dd>`s. How might you extend the helpers to support that? _NOTE: Even I haven't thought about the best way to do this so it's definitely a good exercise_