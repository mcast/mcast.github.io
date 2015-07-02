---
title: Things a Jekyll website wants (part 2)
tags: metablog
published: false
---

Things I haven't added, but probably will

* Machine readable, for search engines
	* [humans.txt](http://humanstxt.org/) is just for humans looking at `robots.txt` data
	* [robots.txt](http://www.robotstxt.org/)
	* [sitemap.xml manifest](http://www.sitemaps.org/)
		* the [jekyll-sitemap gem](https://github.com/jekyll/jekyll-sitemap) does this
			* the [Github Pages howto](https://help.github.com/articles/sitemaps-for-github-pages)
			* exclude pages with frontmatter `sitemap: false`
			* check the `<lastmod>` values and wonder if you want to fix them up
* What changed recently?
	* RSS or atom.xml
	* link from `<head>`
* Favicons
	* The original `/favicon.ico`
	* other versions for various devices?
* Other content for `<head>`
* Collection of reference URLs for the authors?
	* or maybe I'll just chase down each gem when I have a problem with it

{% include div-WiP.html %}
