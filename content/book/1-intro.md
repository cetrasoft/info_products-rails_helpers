# Introduction

## Why write this book?

If you're reading this, whether you're a novice, amateur, or professional developer, you're probably the type who takes investing in their continuing education seriously. You're always up-to-date with current methodologies and the latest tricks of your trade. Your thirst for the "perfect solution" or the "best way" is unquenchable. You subscribe to popular development blogs, have taken or are taking courses, and attend meetups. When faced with a challenge you'll travel far and wide to close the gap between a "good enough" solution and an elegant one.

**You're serious about being good at what you do and it feels fantastic to be at the top of your game!**

Like you, we're always looking for ways to take our game to the next level, and once upon a time this brought us to reassess our Rails views and Bootstrap front-end code.

As most Rails projects at the time, the state of things were somewhat of a mess: our Rails helpers had become a dumping ground with no real organization, filled with ugly HTML and CSS classes. Our views were using these helpers, but simply to just hide code away elsewhere without leveraging any techniques to further reusability. Our usage of partials vs. helpers was wrong and inconsistent. 

Sound familiar? If it doesn't, you may want to check again.

This flew by for a while, and even though we could've continued to cop out and blame it on the bad reputation that helpers get, we knew there had to be a better way. Besides, we were tired of stepping on our own toes when it came to making changes on the front-end.

Unfortunately, helpers are not widely covered by the Rails community. In general, good view layer architecture is touched upon very little by standard Rails documentation, with much of the spotlight going to the back-end heavy-lifting (controllers, models, migrations, routes). That's great and all, but can the front-end get a little love? Helpers you'll find documented out there on the internet are simply a mess of functions slung together. 

Once we started seriously working on architecting our Bootstrap Rails one-method helpers into full-fledged models, we realized what an amazing exercise in Ruby, Rails, and Object Oriented Programming it was!

## Who we are

So, what makes us qualified to teach a course on any of these fronts?

We're Ryan & Carlos, a couple of dudes who use Rails professionally and love it. We're passionate about doing things the right way&trade;, not only because it feels good, but because it actually makes writing code easier.

We've built our consulting business on Rails. Quite an investment to make in one particular technology, but it has never let us down!

At the end of the day it's simple: we're a couple of guys very concerned with improving ourselves on the daily, much like you are.  We want to share what we've learned with you to help you get closer to reaching Rails enlightenment a bit faster than we did. 

## Why do I need this course?

Bootstrap helpers? Why can't I just use XYZ gem?

Your front-end frameworks *du jour* will come and go. On top of that, eventually you'll run into a project, as we did, where you don't want to (or can't for whatever reason) use Bootstrap or Foundation. You may even write your own!  For these reasons, it helps to be prepared by being comfortable with rolling out your own architecture for your own front-end frameworks and project-specific structures.

Another thing: experienced developers know that there comes a time where you'll strongly disagree with a gem developer's design decisions. That's why there's forking! Learning from our examples will empower you to fork and modify code to suit your own needs in awesome ways that will blow other developers away.

Learn to make your Rails views more modular and more scalable with us! So shall we?

## Helpers, presenters, partials... WTF!

Sometimes it gets confusing to know when you should employ certain patterns. Before we get started, let's clear the air about what should be used when and where:

### Helpers

If you're looking to output HTML dynamically generated based on some input (like method parameters or a block) look towards helpers for getting the job done. Helpers should be used for generating recurring structures in your HTML (e.g. forms, modals, tabs, links, etc.) that differ slightly from one to the other based on the arguments you pass. Rails' own `link_to` helper is a great simple example.


```ruby
link_to "Visit Other Site", "http://www.rubyonrails.org/", data: { confirm: "Are you sure?" }
```

The more complex Rails `form_for` helper is a good example of an advanced helper (the kind we'll be getting into):


```erb
<%= form_for @person do |person_form| %>
  Name: <%= person_form.text_field :name %>
  Admin: <%= person_form.check_box :admin %>
<% end %>
```

The meat of this course will go into how you can build helpers like these around front-end UI/UX patterns like those found in Bootstrap. Once you've studied the examples and learned the concepts, you can apply the same techniques to build helpers for any front-end framework of your choosing!

### Presenters

Presenters are used to return a "presentable" representation of some data, often based on certain conditions.
The below presenter will show a user if and when a post was published:

```ruby
def published_at
  if @article.published_at
    time_ago_in_words(@article.published_at)
  else
    'Draft'
  end
end
```

Assuming `@article` is an instance of your presenter which wraps the original model, you use it in your view like this:

```erb
<article>
  <%= @article.title %>
  <%= @article.published_at %>
</article>
```

In general, if you need a value (in this case, the raw date `@article.published_at`) formatted nicely, you should employ a presenter to abstract code away from your view.
Here we'll get `"5 days ago"` as output from something like `"2011-02-20 08:01:55.583222"`.

Your values can and should be stored in their most raw form, absent of any pretty formatting! Along with dates, this can also apply to currencies (adding the `"$"` and correct number of decimal places to `100.5`) or degrees of temperature (adding the &deg;F symbol to `75`).

Helpers and presenters work together to keep your code DRY (don't repeat yourself), readable, and tidy.

### Partials

Although you can technically pass data into partials, don't use partials where helpers should be used. Here's an example of what not to do:

```erb
<%# index.html.erb %>
<%= render 'description_list', locals: { object: @person, attributes: [:first_name, :last_name, :email] } %>
```

```erb
<%# _description_list.html.erb %>
<% if @attributes.any? %>
  <dl class="<%= horizontal ? 'horizontal' : '' %>">
    <% attributes.each do |attribute| %>
      <dt><%= attribute.to_s.titleize %></dt>
      <dd><%= @person.send(attribute) || "-" %></dd>
    <% end %>
  </dl>
<% end %>
```

This is a job for a helper. Why? Since helpers are just Ruby you can make use of OOP techniques, store state, and implement complex logic in a modularized and unobtrusive way. As you'll soon start to learn, the above way is not very flexible. On top of that, it looks ugly (actually, identifying ugly code often goes a long way in helping you improve it)!

In this course, we'll take something like the above Bootstrap definition list, and implement it in a much cleaner and more reusable way. You're going to *love* the result. Your code will too.

Partials *should* be used for layouts and where code is repeated, but whose markup structure does not change depending on what's passed in as arguments. Here's a good example of proper partial usage:

```erb
<%# index.html.erb %>
<h1>Products</h1>
<%= render partial: 'product', collection: @products %>
```

```erb
<%# _product.html.erb %>
<p>Product Name: <%= product.name %></p>
```

The markup structure stays the same here; only the values change.

### Summary

In short, if the generation of HTML isn't involved, don't use a helper. If what you're trying to do is formatting-related, use a presenter. If neither applies, see if a partial makes sense, otherwise it probably belongs directly in the view.

It's okay if you're not 100% clear on the differences yet.
Practice makes perfect, so let's get to writing some helpers!