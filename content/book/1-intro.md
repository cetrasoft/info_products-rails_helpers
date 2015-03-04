# Introduction

## Why write this book?

If you're reading this, whether you're a novice, amateur, or professional developer, you're probably the type who takes investing in their continuing education seriously. You're always up-to-date with current methodologies and the latest tricks of your trade. Your thirst for the "perfect solution" or the "best way" is unquenchable. You subscribe to popular development blogs, have taken or are taking courses, and attend meetups. When faced with a challenge you'll travel far and wide to close the gap between a "good enough" solution and an elegant one.

**You're serious about being damn good at what you do and it feels fantastic to be at the top of your game!**

Like you, we're always looking for ways to take our game to the next level, and once upon a time this brought us to reassess our Rails views and Bootstrap front-end code.

As most Rails projects at the time, the state of things were somewhat of a systematic mess: our Rails helpers had become a dumping ground with no real organization, filled with ugly HTML and CSS classes. Our views were using these helpers, but simply to just hide code away elsewhere without leveraging any techniques to further reusability. Our usage of partials vs. helpers was wrong and inconsistent. 

Sound familiar? If it doesn't, you may want to check again.

This flew by for a while, and even though we could've continued to cop out and blame it on the bad reputation that helpers get, we knew there had to be a better way. Besides, we were tired of stepping on our own toes when it came to making changes on the front-end.

Unfortunately, helpers are not widely covered in the community. In general, good view layer architecture is touched upon very little by standard Rails documentation, with much of the spotlight going to the back-end heavy-lifting (controllers, models, migrations, routes). That's great and all, but can the front-end get a little love? Helpers you'll find documented out there on the internet are simply a mess of functions slung together. 

Once we started seriously working on architecting our half-assed Bootstrap Rails one-method helpers into full-fledged models, we realized what an amazing exercise in Ruby, Rails, and Object Oriented Programming it was. And fun as hell to boot!

## Who we are

So, what makes us qualified to teach a course on any of these fronts?

We're Ryan & Carlos, and we've been building web apps professionally for over 10 years (with Rails for 5 of those years). Rails has been out for 9 years at the time of this writing, so you could say we've been using exclusively Rails for the majority of the time it has been around.

We've built our consulting business on Rails, with the apps for all of our customers running a version from 2 to 4. Quite an investment to make in one particular technology, but it has never let us down!

At the end of the day it's simple: we're a couple of guys very concerned with improving ourselves on the daily, much like you are.  We want to share what we've learned with you to help you get closer to reaching Rails enlightenment a bit faster than we did. 

## Why do I need this course?

Bootstrap helpers? Why can't I just use XYZ gem?

Your front-end frameworks *du jour* will come and go. On top of that, eventually you'll run into a project, as we did, where you don't want to (or can't for whatever reason) use Bootstrap or Foundation. You may even write your own!  For these reasons, it helps to be prepared by being comfortable with rolling out your own architecture for your own front-end frameworks and project-specific structures.

Another thing: experienced developers know that there comes a time where you'll strongly disagree with a gem developer's design decisions. That's why there's forking! Learning from our examples will empower you to fork and modify code to suit your own needs in awesome ways that will blow other developers away.

Learn to make your Rails views more modular, more scalable, and more sexy with us. Or for those of you "glass half-empty" people: make them suck less.

So shall we?

## Helpers, presenters, partials... WTF!

Sometimes it gets confusing to know when you should employ certain patterns. Before we get started, let's clear the air about what should be used when and where:

### Helpers

If you're looking to output HTML dynamically generated based on some input (like method parameters or a block) look towards helpers for getting the job done. Helpers should be used for generating recurring structures in your HTML (e.g. forms, modals, tabs, links, etc.) that differ slightly from one to the other based on the arguments you pass. Rails' own `link_to` helper is a great simple example.


```ruby
link_to "Visit Other Site", "http://www.rubyonrails.org/", data: { confirm: "Are you sure?" }
```

The meat of this course will go into how you can build helpers like these around front-end UI/UX patterns like those found in Bootstrap. Once you've studied the examples and learned the concepts, you can apply the same techniques to build helpers for any front-end framework of your choosing!

### Presenters

Presenters are used to return a "presentable" representation of some data, often based on certain conditions. The below presenter will show a user vital information on if and when a post was published:


```ruby
def publication_status
  if @model.published_at?
      h.time_ago_in_words(@model.published_at)
  else
    'Draft'
  end
end
```

Helpers and presenters often and should work together to keep your code DRY (don't repeat yourself). For example, you might utilize a presenter inside of a helper, like so:

```ruby
def helper
    # TODO
end
```

See how that helps things stay clean? 

### Partials

Although you can technically pass data into partials, don't use partials where helpers should be used. Here's an example of what not to do:

```ruby
# path/to/file.html.erb
= render partial: 'something', locals: { title: 'xyz' }
``` 

```ruby
# path/to/file.html.erb
# TODO
``` 

This is a job for a helper? Why? [explanation]

Partials should be used for layouts and where code is repeated, but whose markup does not change depending on what's passed in as arguments. Here's a good example of proper partial usage:

```ruby
# path/to/file.html.erb
# TODO
```

```ruby
# path/to/file.html.erb
# TODO
```