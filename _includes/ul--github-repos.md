
/* https://help.github.com/articles/repository-metadata-on-github-pages/
 * This inclusion isn't so useful, because it won't update until rebuilt!
 */

## Repositories on Github
{% for repository in site.github.public_repositories %}
* [{{ repository.name }}]({{ repository.html_url }}){% endfor %}

Test:

<pre>#! /usr/bin/env ruby
require "psych"

d = {"repos"=>[
{% for repository in site.github.public_repositories %}  {{ repository }},
{% endfor %}
	]}
print Psych.dump(d)
</pre>
