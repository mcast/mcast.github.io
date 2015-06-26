---
title: Try Everything
layout: post
category: test silly everything
tags: sillier test
published: true
date: 2015-06-27
redirect_from: /come-from
permalink: xmastree-post.html
---

## Switch on all the options to see what happens
{:title="attr test heading" style="background: yellow"}

* All the frontmatter variables I have found so far.
* So I can remember what they are, and what they do.

## Repositories on Github
{% for repository in site.github.public_repositories %}
* [{{ repository.name }}]({{ repository.html_url }}){% endfor %}

Code blocks {#code}
----

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
def post
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

To **boldly** split infinitives.

[^1]: usually code gets longer by growing in the editor window,
  but it can also get longer when the compression comes unravelled.

*[CPU]: Chocolate Party Unit
