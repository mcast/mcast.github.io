---
title: Things a Jekyll website wants (part 2)
tags: metablog
published: false
---

# {{ page.title }}

{% include div-WiP.html %}
Things I haven't added, but probably will

* Machine readable, for search engines
	* [humans.txt](http://humanstxt.org/) is just for humans looking at `robots.txt` data
	* [robots.txt](http://www.robotstxt.org/)
		* `Disallow:` entries can be inserted under control of frontmatter
	* [sitemap.xml manifest](http://www.sitemaps.org/)
		* the [jekyll-sitemap gem](https://github.com/jekyll/jekyll-sitemap) does this, see the [Github Pages howto](https://help.github.com/articles/sitemaps-for-github-pages)
		* I found comparing [this earlier plugin-less sitemap.xml solution](http://davidensinger.com/2013/03/generating-a-sitemap-in-jekyll-without-a-plugin/) instructive

Still missing

* What changed recently?
	* RSS or atom.xml
	* link from `<head>`
* Favicons
	* The original `/favicon.ico`
	* other versions for various devices?
* Other content for `<head>`
* Collection of reference URLs for the authors?
	* or maybe I'll just chase down each gem when I have a problem with it

### Sitemap control

You may need to study the Liquid template which generates your `sitemap.xml` to get this right.  I'm using [this one](https://github.com/jekyll/jekyll-sitemap/blob/master/lib/sitemap.xml) in `jekyll-sitemap`.

* exclude pages with frontmatter `sitemap: false`
* look at the sitemap.xml and check the `<lastmod>` values, then wonder if you want to fix them up
	* posts are given midnight on their `date`, which is actually the earliest possible time
	* pages don't have a modification time unless you set one

I decided to update frontmatter timestamps from the Git commit times - TODO: link it - a work in progress.

### HTTP modification time

Currently (Jekyll 2.4.0, 3.1.2) the `Last-Modified:` time seems to be the site build time.

It would be nice if it matched the sitemap time.  Something to investigate later.  Maybe it could set files' mtimes when they're known?

## References

* <http://pixelcog.com/blog/2013/jekyll-from-scratch-core-architecture/#sitemaps-and-robotstxt>
