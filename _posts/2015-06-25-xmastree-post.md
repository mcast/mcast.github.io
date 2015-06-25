---
title: Try Everything
layout: post
category: test silly everything
tags: sillier test
published: false
date: 2015-06-26
redirect_from: /come-from
permalink: xmastree-post.html
---

# Try Everything
## Switch on all the options to see what happens
* All the frontmatter variables I have found so far.
* So I can remember what they are, and what they do.

## Repositories on Github
{% for repository in site.github.public_repositories %}
  * [{{ repository.name }}]({{ repository.html_url }})
{% endfor %}

