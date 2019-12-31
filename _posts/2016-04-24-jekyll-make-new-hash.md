---
title: "Jekyll: make a new hash"
tags: metablog
last_modified_at: 2016-04-24 16:07:21 +0100
---

I'm using

* Jekyll (3.1.2 local install for debugging, plus whatever Github Pages has for the live copy)
* This [handy cheatsheet](http://cheat.jekyll.tips/) as reference material

I wanted to create a new hash object, and constructs like these don't work:

{% raw %}
```
{% assign h = { "foo" => 6, "bar" => 7 } %}
{% assign h["foo"] = 6 %}
```
{% endraw %}

This does work though.  In `_includes/mkhash.inc` just

{% raw %}
```
{% assign h = include %}
```
{% endraw %}

and in the requesting page,

{% raw %}
```
{% assign arr = '' | split: '.' %}

{% include mkhash.inc foo = 6 bar = 7 %}
{% assign arr = arr | push: h %}

{% include mkhash.inc whiz = 8 bang = 9 %}
{% assign arr = arr | push: h %}

{{ arr | jsonify }}
```
{% endraw %}

producing

{% assign arr = '' | split: '.' %}

{% include mkhash.inc foo = 6 bar = 7 %}
{% assign arr = arr | push: h %}

{% include mkhash.inc whiz = 8 bang = 9 %}
{% assign arr = arr | push: h %}
```
{{ arr | jsonify }}
```
