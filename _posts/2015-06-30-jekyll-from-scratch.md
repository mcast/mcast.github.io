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
* Serve it with Apache, from the old desktop box under the stairs, down the rather asymmetric cablemodem
* A vague intention to [make it clean](https://validator.w3.org/)

That website is still up, moved to a [Bytemark](https://www.bytemark.co.uk/) small VM, but mostly untouched for many years.  The CVS repository never made it into Git and what I wanted to tell the world fitted OK as a [contribution to some other service](/about.html).

## Website refresh

Here I say "choose" rather than "design" or "build".  My vapourware queue already exceeds my allotted CPU cycles.

### Static is cool

Static blogs make a lot of sense, this has been clear to me for some years now.  But which?

* Choose by features, implementing language, or just popularity?
* For the less obscure ones, choose the clone-and-go blog template pack, which probably brings some "themes".
[ ] Link a few, once I remember where I stashed that research.

{% include div-WiP.html %}

### Choose the engine

I use [Github](https://github.com) already.  It has [Github Pages](https://pages.github.com/).

Maybe I don't want to be tied to Github forever?

1. I will CNAME it to my own URL anyway.
2. I could run the Jekyll generator myself, or ask [Travis CI](https://travis-ci.com/) to do it for me.
	* There is the [`github-pages` gem](https://github.com/github/pages-gem#list-dependency-versions) to [get the correct versions of everything](http://jekyllrb.com/docs/github-pages/#deploying-jekyll-to-github-pages).
3. I could serve it off my own webserver...  haven't been Slashdotted yet, it'll be fine.

So the only tie is convenience, or lack of some feature I don't yet know I want.  Ask again in five years?

### Choose the styling

[Old school](https://en.wikipedia.org/wiki/Old_school#Computers_and_gaming) [angry fruit salad](http://www.catb.org/jargon/html/A/angry-fruit-salad.html), what's not to like?

I'll start writing content.  I could change the CSS later if I wanted.

### Choose the markup

* HTML is still a valid choice
	* The obvious choice for the layouts
	* The escape hatch for tricky articles
* [Markdown](http://daringfireball.net/projects/markdown/) looks like the defacto standard, and is easy enough for prose.
	* Is that [GFM](https://help.github.com/articles/github-flavored-markdown/) or some other dialect?
	* Do I want to use another language with [so much](http://www.adamhyde.net/whats-wrong-with-markdown/) [undefined behaviour](http://www.wilfred.me.uk/blog/2012/07/30/why-markdown-is-not-my-favourite-language/)?
	* Works on Github Pages, so is the sensible choice there.
	* I don't like the dialect issues, but I have been known to *locally extend standards* myself sometimes.
* Several people recommended [HAML](http://haml.info/) to me.
	* [ ] "Give myself 5 minutes" to learn it.
	* [ ] Shoe-horn it into Jekyll?
* [WikiCreole](http://www.wikicreole.org/wiki/Implementation) is already familiar.
* [ ] Org-mode is supported by Jekyll and GitHub in general, but not Github Pages.  I could ask.

I can choose markup language per layout/article/inclusion, within the ghpages constraints.  Markdown is good enough for now.

### Choosing the markdown renderer

I took the list of renderers to try from the [pages-gem](https://github.com/github/pages-gem/blob/master/lib/github-pages.rb) source.  After the first pass of evaluation I discovered that some take a list of extension flags.

* maruku [was used for Github Pages](https://help.github.com/articles/migrating-your-pages-site-from-maruku/) but [is obsolete](http://benhollis.net/blog/2013/10/20/maruku-is-obsolete/)
* [rdiscount](https://github.com/davidfstr/rdiscount)
	* Renders triple-backticks, with a class for the language.
	* Doesn't call pygments for syntax highlighting?
	* Doesn't render pipe tables, header `{#id}` marks, attribute lists `{: foo=bar}` of any sort.
	* Doesn't understand `*[abbr]: abbreviation definition` blocks.
	* I didn't try to [configure it](http://www.rubydoc.info/github/davidfstr/rdiscount/master/RDiscount#constructor_details), but it doesn't seem to offer fenced code blocks anyway.
* redcarpet
	* Used for [github/markup](https://github.com/github/markup#markups) (2015-06-26)
	* [Can do GFM](http://stackoverflow.com/questions/13464590/github-flavored-markdown-and-pygments-highlighting-in-jekyll)
	* Jekyll docs [were updated](https://github.com/jekyll/jekyll/pull/1418) with relevant extension info.
	* Doesn't render header `{#id}` marks or attribute lists `{: foo=bar}`
	* Does put id tags on headers in case you have (DIY?) TOC.
	* Footnote definitions bring their own `<hr>`
* RedCloth
	* Looks similar to redcarpet with extensions switched off..?
	* Broke the build for syntax error in `#excerpt`
* kramdown - the current (2015-06) default markdown render
	* Renders pipe tables
	* Doesn't render triple-backtick code blocks out of the box
	* For GFM, configure `{ kramdown => { input => 'GFM' } }`.  [Thanks Milan!](http://milanaryal.com/2015/writing-on-github-pages-and-jekyll-using-markdown/#for-kramdown-markdown)

This was not a comprehensive survey or a thorough test, but it is clear to me that

* one should should take diffs of the HTML outputs when considering switching
* the choice is between [Kramdown's GFM](/test/xmastree-post.kramdown.html) or a [configured Redcarpet](/test/xmastree-post.redcarpet.html) - I took these snapshots of [my test page](/xmastree-post.html) for comparison.

From the config, it looks like each article could choose the renderer, but Jekyll 2.4.0 ignores it.  `_config.yml` sets the **global choice** for all `.md` articles in the site.

### URLs are for life, not just for Christmas

It has been true [since 1998](http://www.w3.org/Provider/Style/URI.html) and the slogan is [not new](https://oracle-base.com/blog/2015/05/25/writing-tips-a-url-is-for-life-not-just-for-christmas/), but still one sees those 404s.

I have old content on old URLs.  It is still there.

[ ] Move it.
[ ] Redirections.

### Standard things a website should have

I started with a blank sheet and wrote my own page templates.  I guess none of the templates I saw already looked like the kind of clothing I like to wear.

Every website is different[^1], but many have common features that people come to expect.  Mine lacks many of them, but I might try to [enumerate them](/website-wants) as I go.

[^1]: Pedantry: except the splog of course.

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
