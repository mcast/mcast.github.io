---
title: Things a Jekyll website wants
tags: metablog
---

# {{page.title}}

In which I attempt to enumerate the things a modern website needs, and
decide whether I want them.

## Added already

* [index](/index.html) aka. home or top page
* [about](/about.html)
* human readable [sitemap](/sitemap.html)
* custom [404](/404.html)
* README.md
	* For the [Github repo view](https://github.com/mcast/mcast.github.io#readme)
	* Also appearing in the [published view](/README.html), unless you mark it unpublished
* Policy on [URL changes](http://www.w3.org/Provider/Style/URI.html), in the [README](/README.html#policies)
* [Sitemap for humans]({{site.baseurl}}/sitemap.html), reliably listing all content.  
  Because most likely I will be the main user.  I constructed this manually, a bit at a time, and expect it to continue changing.
* Layout control.  I grabbed [the Unsemantic grid]({{site.baseurl}}/2016/04/18/unsemantic-fluid-grid.html).

though some of these start with a "work in progress" mark.

## Not yet implemented

Things I haven't added, but probably will

* Styling
	* Link target highlight, for when the page scroll isn't enough.  (Why doesn't the UI do this anyway?)
	* Heading link-copying on hover; may be tricky if the Markdown formatter doesn't do it for me.
	* TOC generator for the longer pages.
* Some kind of decoration to offset the default HTML theme.  Maybe [a rainbow](http://www.t8o.org/moved.jpeg) would be nice, but I'll pass on the otherwise popular unicorn.
* Comments on posts.  Currently I expect to link back to blog posts made in reply.  This requires...
* Contact me?  Email would be fine, but my inbox has been badly overstuffed with spam so I want a safe way to do that.  Without relying on a third-party website.

## Unwanted

Some people like these, but they're not for me just now.

* Adverts.  You don't want them, neither do I.
* CSS Reset.  Turns out, I think the browser designers have done a nice job and I'll stick with that.  I had no expectation of pixel-exact layout and don't mind a little irregularity from oner UI to another.

