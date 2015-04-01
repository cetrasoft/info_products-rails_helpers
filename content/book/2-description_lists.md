# Description lists

Part of Bootstrap's typography CSS, description lists make perfect sense as an initial example: simple, yet useful. This is great for debugging and displaying information about an application entity such as a `User` on a `show` page, for example.

Let's jump in and see what we're talking about here!

First, let's get familiar with the structure of a description list. They look like this:

![alt](../images/2-description_lists/example_1.png)

Bolded items named "Term" are wrapped in HTML5 **term elements**, specified in HTML with the `<dt>` tag.

"Description" items are wrapped in HTML5 **description elements**, specified in HTML with the `<dd>` tag. So something like the above looks like this in HTML:

```html
<dl>
  <dt>Term</dt>
  <dd>Description</dd>
  <dt>Term</dt>
  <dd>Description</dd>
  <dd>Description</dd>
  <dt>Term</dt>
  <dd>Description</dd>
</dl>
```

Here, the `<dl>` tag defines an HTML5 **description list**. We put our terms (`<dt>`s) and definitions (`<dd>`s) within this wrapper element.

Here's an a real example in action:

![alt](../images/2-description_lists/example_2.png)

Which looks like this in code:

```html
<dl>
  <dt>Id</dt>
  <dd>12345</dd>
  <dt>Name</dt>
  <dd>Ryan</dd>
  <dd>Jafari</dd>
  <dt>Location</dt>
  <dd>New York, NY</dd>
</dl>
```

Can you can see how this would be helpful in printing out the properties of an object?

By the way, Bootstrap gives us the option of changing the orientation of the definition list by applying the `dl-horizontal` class to the `dl` element. That will make the above list look like this:

![alt](../images/2-description_lists/example_3.png)

Terms and their subsequent descriptions are now organized horizontally instead of vertically (the default). Our helpers will definitely be able to handle this option!

---

Now that we've gotten you familiar with the structure of what we want our Rails helpers to output, we can dive into building the actual helpers themselves!

# The `DescriptionListHelper`

## Context

Before we dive into the helper code, let's set the stage for what we want to implement here by checking out what we'll eventually be able to do in our view:


```erb
<h1>Description Lists</h1>

<% @person = OpenStruct.new(first_name: 'Carlos', last_name: 'Ramirez', email: 'carlos@cetrasoft.com') %>
<% @attributes = [:first_name, :last_name, :email] %>

<%= description_list_for @person, @attributes, true %>
```

Our eventual `description_list_for` helper will allow us to pass in an object (in this case, `@person`), an array of attributes (here, `@attributes`) and whether or not we want the description list to display horizontally (here we do, with `true`).

And don't be afraid of old `OpenStruct` up there. That's just something we're doing here for demo purposes to allow us to create an object on the fly, without having to go into building a model. In real-world usage, you'd have a model defined elsewhere in your application, like you should. In that case, you'd be looking at simply:

```erb
<h1 class='page-header'>Description Lists</h1>

<%= description_list_for @person, [:first_name, :last_name, :email], true %>
```

So just bear with us for the sake of the demo!

***PROTIP:*** You might be asking, like we once were:

> Why do I need to pass in a list of attributes? Why can't my helper just look at the object and pump them all out?

Glad you asked, because doing that would be pretty bad. Why? You don't want to blindly iterate over all the object's attributes because that's too heavy-handed (i.e. it will include things that aren't user-friendly such as `created_at` and `updated_at`). Imagine too, that your object has a ton of properties. It makes sense that you'd probably only be interested in a subset of those, which you can specify here as `@attributes`. If you just iterated over all them in your helper code, you wouldn't have that luxury. Nice!

Okay, so how do we build `description_list_for` already? Let's do it!

## The helper

We'll assume you know where to put your helper code (hint: it's in the helpers folder of your Rails project!) Set yourself up with something like this:

```ruby
# app/views/helpers/description_list_helper.rb
module RailsHelpersCodeSamples
  module DescriptionListHelper
    def description_list_for(record, attributes, horizontal = false)
      # TODO
    end
  end
end
```

Take a look at our method signature `description_list_for(record, attributes, horizontal = false)`. From following along above, you already know why it looks like this, but as a reminder: 

- The `record` argument is for your model object,
- `attributes` will be an array of symbols that specify attribute or property names (think `:first_name`, `:last_name`),
- and horizontal indicates whether the description list should be styled to display horizontally or not (the default here, as you can see, is set to no, or `false`).

Perfect! We're off to a good start then.

For setup, let's right away get the style class for the description list (remember, the `<dl>` element), shall we?

```ruby
module RailsHelpersCodeSamples
  module DescriptionListHelper
    
    def description_list_for(record, attributes, horizontal = false)
      style = horizontal ? 'dl-horizontal' : ''
    end
  
  end
end
```

A simple shorthand `if` statement that stores the horizontal style class in our `style` variable for use later if `horizontal` has been set to true. If it was set to false, it just stores a blank (nothing).

Here's where you're really going to have to start paying attention!

Let's start by compiling our `<dt>` (term) and `<dd>` (description) elements in pairs. The `<dt>` will contain the object's attribute name and the `<dd>` will contain the attribute's value. We'll do this because once we have all of our pairs, we'll just plop them into a `<dl>` and call it a day.

```ruby
module RailsHelpersCodeSamples
  module DescriptionListHelper
  
    def description_list_for(record, attributes, horizontal = false)
      style = horizontal ? 'dl-horizontal' : ''
      pairs = attributes.map { |a| description_list_pair_for(record, a) }
    end
    
  end
end
```

Here, using the `map` method, we'll iterate over the attributes and use each one along with the model object `record` as arguments to the `description_list_pair_for` method. The result will be a `<dt>` and `<dd>` pair added to our `pairs` array.

Don't worry, we'll be more concrete with what exactly that looks like shortly. For right now, all you need to know is that `description_list_pair_for` is going to handle the creation of each pair for us.

### Project or domain-specific helper methods

It's nearly always prudent to separate project or domain-specific functionality from generic functionality when possible, building the former on top of the latter. This way, you can DRY (don't repeat yourself) up your code by leveraging the generic functionality in other areas of your application, or even other completely different applications you build in the future. Building larger and more complex code from smaller, simpler code is always a good rule of thumb for coding in general, and our Rails Bootstrap helpers are no exception!

Let's walk backward. The `description_list_for` method we are in the processing of writing, above, is our most project-specific method in our `DescriptionListHelper` module. It is the method we directly use in our views to render beautiful description lists. Easy to understand. What about the not yet built `description_list_pair_for` method?

As you'll see, this method will still be project-specific. It's in this method that we can make assumptions about how it's being used in our application. What does this mean? It means we can place any kind of domain-specific logic here if we wanted to. For example, we might decide we want to truncate the property value that will be inserted into a `<dd>`, based on some if/else logic that's specific to our "Widgets" application. For demo purposes here, we'll illustrate the project-specific nature in a simpler way, with a simple `titleize`.


It follows then that the `description_list_pair_for` method will *not* be reusable across projects. That's okay though, because not all methods should be. We'll arm you with good generic, reusuable methods that are candidates for your `lib` folder (the place where that stuff goes) when the time comes!

### `description_list_pair_for` 

Back to it then. Like we said, let's start off defining this method with some project-specific love:

```ruby
module RailsHelpersCodeSamples
  module DescriptionListHelper
  
    def description_list_pair_for(record, attribute)
      term        = attribute.to_s.titleize
      definition  = record.send(attribute)
      
      description_list_pair(term, definition)
    end
    
    # def description_list_for(record, attributes, horizontal = false)
    # ... (hidden for simplicity) ...
    # end
    
  end
end
``` 

A small example of project-specific logic is shown above, where we `titleize` the property name that will become our description `term`. First, we convert `attribute` to a string (since in our example it's a symbol like `:first_name`). That gives us `"first_name"` which we then call `titleize` on to make it pretty, yielding `"First Name"`. 

This is a basic example, but any kind of special project-specific handling, say truncation of the definition as another example, would be handled here in this project-specific method.

Finally, we get the value of the model's attribute using `record.send(attribute)`. We store that in our `definition` variable, which will eventually be used in constructing the definition/description element (`<dd>`) that accompanies our term or `<dt>` element above.

This leads us to the final line in this method, where we create the `<dt>`, `<dd>` pair from the `term` and `definition` using the generic `description_list_pair` method. Remember, where project-specific methods can't be used across projects, generic ones can. Let's take a look:

```ruby
module RailsHelpersCodeSamples
  module DescriptionListHelper
  
    def description_list_pair(term, definition)
      tags = [
        content_tag(:dt, term),
        content_tag(:dd, definition.presence || '-')
      ]
      safe_join(tags)
    end
    
    # def description_list_pair_for(record, attribute)
    # ...
    # end
    
    # def description_list_for(record, attributes, horizontal = false)
    # ...
    # end
    
  end
end
```

Simple. We want our two tags `<dt>` and `<dd>` to sit side-by-side within the `<dl>`, with the term first and the description second. To do this, we're going to put each tag, created by `content_tag` using the type of element (as a symbol) and the value, in order in an array. `safe_join` will take our tags in the `tags` array and squash them into a string, suitable and safe for use in our HTML. Nice! It will look something like this

```bash
$ tags
=> ['<dt>First Name</dt>', '<dd>Ryan</dd>']

$ safe_join(tags)
=> '<dt>First Name</dt><dd>Ryan</dd>'
```

Why `safe_join`? `safe_join` is a nice way to concatenate tags and different parts together. You could use `+` or `<<` or even `Array.join` but you have to remember to call `html_safe` on it. `safe_join` does this for you automatically.

Not so bad right?

But what's with the `definition.presence || '-'`? A `term` (remember, the same as an attribute for our purposes here) will always be present, but a `definition`, or value for that attribute, can be missing if our application has never defined it (say the user left their name blank, for example, when filling out a form).  We could have just left it as plain old `content_tag(:dd, definition)`, but because of an existing ["bug"](http://ryanjafari.me/blog/2014/04/01/gotcha-with-html-definition-lists-dls-and-bootstrap-3s-dl-horizontal-class/) in Bootstrap, a `<dd>` must always have something inside of it! If `definition` turned out to contain nothing, our `<dl>` structure would bug out due to one of its `<dd>` elements not having anything inside of it.

So, `definition.presence || '-'` just says "if there is a definition present, display it, otherwise put a dash." We could have put a blank (`' '`) or `'not present'` as well, so long as we had something there and not nothing.

What makes this method generic? Easy. It takes two string values and puts them into the standard `<dl>` structure. It doesn't attempt to do anything fancy or project-specific, and because a `<dl>` construct is HTML, it can easily be used across many different (web) projects and probably belongs in the lib folder.

Are you ready for this? We're about to put it all together!

```ruby
module RailsHelpersCodeSamples
  module DescriptionListHelper
  
    # def description_list_pair(term, definition)
    #   tags = [
    #     content_tag(:dt, term),
    #     content_tag(:dd, definition.presence || '-')
    #   ]
    #   safe_join(tags)
    # end
    
    # def description_list_pair_for(record, attribute)
    #   term        = attribute.to_s.titleize
    #   definition  = record.send(attribute)
    #   
    #   description_list_pair(term, definition)
    # end
    
    # def description_list_for(record, attributes, horizontal = false)
    #   style = horizontal ? 'dl-horizontal' : ''
    #   pairs = attributes.map { |a| description_list_pair_for(record, a) }
    #   
        content_tag(:dl, safe_join(pairs), class: style)
      end
  end
end
```

Finally, we head back over to our `description_list_for` method and add the last line where we create our `<dl>` description list tag with `content_for`. We pump in all of the `<dt>` & `<dt>` pairs, which by now reside in the `pairs` array, and then `safe_join` them like we did above, readying them for HTML rendering. That looks like this:

```bash
$ pairs
=> ['<dt>First Name</dt><dd>Ryan</dd>', '<dt>Last Name</dt><dd>Jafari</dd>', '<dt>Birthdate</dt><dd>2/13/00</dd>']

$ safe_join(pairs)
=> '<dt>First Name</dt><dd>Ryan</dd><dt>Last Name</dt><dd>Jafari</dd><dt>Birthdate</dt><dd>-</dd>'
```

And at last, when we call this last `content_for` line, the `safe_join(pairs)` content is wrapped by a `<dl>` with the horizontal class appended if we specified that we wanted a horizontal description list. Let's see what it looks like in the end:

```bash
$ content_tag(:dl, safe_join(pairs), class: style)
=> "<dl class='horizontal'><dt>First Name</dt><dd>Ryan</dd><dt>Last Name</dt><dd>Jafari</dd><dt>Birthdate</dt><dd>-</dd></dl>"
```

That right there will be returned to our view and presented to our users in a browser with beautiful Bootstrap styling. Amazing. Are you amazed? Just about, we bet.

Remember, you can keep using the smaller pieces (here the generic `description_list_pair` method) to build bigger, more comprehensive helpers. The modularity of the smaller helpers will ensure that you won't end up with a giant brittle helper that can never be changed.

### Further study

A single `<dt>` can have multiple `<dd>`s. How might you extend the helper and its methods to support that?
