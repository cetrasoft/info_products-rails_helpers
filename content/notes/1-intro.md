# Introduction

## Why Write This Book

* Rails helpers get a bad reputation because they end up being a dumping ground with no organization
* Helpers are not widely covered in the community, especially not in code academies and bootcamps (?)
* It's a fantastic way to dive deeper into Rails and gain a deeper knowledge
* The helpers we've seen in the wild are generally built as a collection (mess) of functions; there is no reason why they can't also be given some object-oriented love. 

## Who We Are

* Ryan and Carlos
* Rails consultants and developers
* We are guys like you just looking to improve our skills and do things in the best way possible

## Bootstrap Helpers? Can't I just use XYZ gem

* There are tons of gems out there that can provide these helpers for free, but the goal is to learn to roll these out on your own and not rely on someone else to do it
* You will gain the ability to write your own helpers for your own frameworks and project-specific structures
* Sometimes you don't agree with the design decisions of the gem author. You need to be able to fork and modify to suit your own needs in a consistent way that other developers/teammates can understand. 

## How are helpers different than presenters?

* Rule of Thumb: helpers output HTML
* Helpers should be used for generating recurring structures in your HTML (e.g. forms, modals, tabs, links, etc.)
* Presenters are used to format data to make it "presentable" (e.g. pretty-printing a date)
* Helpers and presenters work together
* The topic of presenters vs. decorators vs. other patterns has been covered a lot. 
  * https://robots.thoughtbot.com/decorators-compared-to-strategies-composites-and
