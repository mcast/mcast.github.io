---
title: Try Markdown
layout: page
category: test silly everything
tags: sillier test
published: true
date: 2015-06-28
permalink: xmastree-post.html
---

# Try Markdown

A non-comprehensive selection of
Markdown constructs, hardwrapped to 40
to make that obvious, such as bald
http://hyperlinks.example.org to see how
they render with the current
`_config.yml`.

## Switch on all the options to see what happens
{:title="attr test heading" style="background: yellow"}

* All the frontmatter variables I have found so far.
* So I can remember what they are, and what they do.

* And ask for a TOC - kramdown only?
{:toc}

## Repositories on Github
{% for repository in site.github.public_repositories %}
* [{{ repository.name }}]({{ repository.html_url }}){% endfor %}

Code blocks {#code}
----

```
simpe pre-format
text block
with no language
```

```perl
#!/usr/bin/perl
use strict;
use warnings;
sub main {
  print "Hello world\n";
  return 0;
}

exit main();
```

> Once upon a time, in a little window on an LCD screen
> lived some code.  Well it wasn't really living there, it
> doesn't get to live until it burrows down to the CPU to
> stretch its legs[^1] and travel on the bus.

~~~
def tidle_fenced_post
  "Pardon?"
end
~~~
{: .language-ruby}

1. One
2. Two
3. Three
1. (One)

thing
: what the thing is

nothing
: what the thing isn't

| Head | Foot|
|----+----|
| Nose | Toes |
| Tooth | Nail |

---

To **boldly** split infinitives and ~~strikethrough~~ other text.

[^1]: usually code gets longer by growing in the editor window,
  but it can also get longer when the compression comes unravelled.

*[CPU]: Chocolate Party Unit

Are "quotes" normal?  Hope so.  Can we _underline_ words without _underlining_private_variables ?  Should be OK when `_they_are_code` like this.  Superscripts are 2^(nd) nature, he contrived.  Highlights are ==new== to me.  By the way, no newlines in this paragraph but just here <br> it does contain a `<br>` tag.

	fn indented() {
	  # don't need these
	  # with fenced code blocks
	}

