---
title: Jekyll on Github Pages, from scratch
tags: metablog
---
## The old solution

Last time [I had web pages](http://www.t8o.org/~mca1001/), it was cool to write them by hand.

* HTML 4, XHTML or whatever - with a doctype
* CSS was the modern way
* Some CGI scripts (for the fancy stuff)
* [CVS](https://en.wikipedia.org/wiki/Concurrent_Versions_System) backed to preserve my changes (and my sanity, so I thought at the time)
* Serve it off the broadband from the old desktop box under the stairs
* A vague intention to [make it clean](https://validator.w3.org/)

That website is still up, moved to a [Bytemark](https://www.bytemark.co.uk/)
small VM, but mostly untouched for many years.  The CVS repository
never made it into Git and what I wanted to tell the world fitted OK
as a [contribution to some other service](/about.html).

## Website refresh

Here I say "choosing" rather than "designing" or "building".  My
vapourware queue already exceeds my allotted CPU cycles.

### Static is cool

Static blogs make a lot of sense, this has been clear to me for some
years now.  But which?

* Choose by features, implementing language, or just popularity?
* For the less obscure ones, choose the clone-and-go blog template pack, which probably brings some "themes".
[ ] Link a few, once I remember where I stashed that research.

{% include WiP.html %}

### Choosing the engine

I use [Github](https://github.com) already.  It has [Github Pages](https://pages.github.com/).

Maybe I don't want to be tied to Github forever?

* I will CNAME it to my own URL anyway.
* I could serve it off my own webserver...  haven't been Slashdotted yet, it'll be fine.
* I could run the Jekyll generator myself, or ask [Travis CI](https://travis-ci.com/) to do it for me.
	* There is the `github-pages` gem to [get the correct versions of everything](http://jekyllrb.com/docs/github-pages/#deploying-jekyll-to-github-pages).

### Choosing the styling

[Old school](https://en.wikipedia.org/wiki/Old_school#Computers_and_gaming)
[angry fruit salad](http://www.catb.org/jargon/html/A/angry-fruit-salad.html),
what's not to like?

I'll start writing content.  I could change the CSS later if I wanted.

### Choosing the markup
* [Markdown](http://daringfireball.net/projects/markdown/) looks like the defacto standard, and is easy enough for prose.
	* Is that [GFM](https://help.github.com/articles/github-flavored-markdown/), [Kramdown](http://kramdown.gettalong.org/syntax.html) or...?
	* Do I want to use another language with [so much](http://www.adamhyde.net/whats-wrong-with-markdown/) [undefined behaviour](http://www.wilfred.me.uk/blog/2012/07/30/why-markdown-is-not-my-favourite-language/)?
* Several people recommended [HAML](http://haml.info/) to me.
	[ ] "Give myself 5 minutes" to learn it.
	[ ] Shoe-horn it into Jekyll.
* [WikiCreole](http://www.wikicreole.org/wiki/Implementation) is already familiar.

I can choose markup language per layout/article/inclusion, within the
ghpages constraints.  Markdown is good enough for now.

### Choosing the markdown renderer

This is less easy because it is a global choice for all `.md` articles
in the site.

* the ghpages default (what is that?) doesn't render triple-backtick code blocks.
* rdiscount renders the triple-backticks, but isn't calling pygments for syntax highlighting.
* [ ] kramdown

Maybe I should take diffs of the HTML when I switch?

### URLs are for life, not just for Christmas

It has been true [since 1998](http://www.w3.org/Provider/Style/URI.html)
and the slogan is [not new](https://oracle-base.com/blog/2015/05/25/writing-tips-a-url-is-for-life-not-just-for-christmas/),
but still one sees those 404s.

I have old content on old URLs.  It is still there.

[ ] Move it.
[ ] Redirections.

### Standard things a website should have

I started with a blank sheet and wrote my own page templates.  I guess
none of the templates I saw already looked like the kind of clothing I
like to wear.

[X] [home](/index.html), [about](/about.html), [sitemap](/sitemap.html) and custom [404](/404.html).
[ ] RSS / atom.xml, link from &lt;head>
[ ] [humans.txt](http://humanstxt.org/)
[ ] [robots.txt](http://www.robotstxt.org/)
[ ] [sitemap manifest](https://en.wikipedia.org/wiki/Sitemaps)
[ ] README.md, for the Github repo view

### Blog about it

It's traditional, you know?  Also, can be self-referential which adds to the fun.

## Notes

* [Jekyll is Not Blogging Software](http://jekyllbootstrap.com/lessons/jekyll-introduction.html#toc_3).  Jekyll is a parsing engine.

### Github Pages hosting
At the time I tested it (2015-06),

* When the `CNAME` file is present in the `$USER.github.io` repo, HTTP 301 redirections are served from https://$USER.github.io/* to http://$CNAME/*
* There are no other redirections from https://$USER.github.io/$PROJECT/ so there would be two copies published if you have all of
	* project gh-pages
	* a `CNAME` file
	* no `$USER.github.io` repo
* The site build will not honour a CNAME which is already used for another site (only tested within my own user account).  Seems to be first come, first served.
* https://*.github.io/ works with a valid certificate, for when it forwards you get plain http://$CNAME/
* https://$CNAME/ works but the certificate is of course wrong.  Get a proper webserver?
* With the `$USER.github.io/CNAME` redirection, what happens to projects' `gh-pages` ???
