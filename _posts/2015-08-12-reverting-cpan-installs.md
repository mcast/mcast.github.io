---
title: Reverting CPAN installs
tags: perl tools blogreply
---

In [On Perl 5.6](http://shadow.cat/blog/matt-s-trout/on-perl-five-six/) Matt presents what I see as a nice middle ground on maintaining compatibility with old code.  No need for comment, except on this:

> For toolchain level code I try a bit harder, because for toolchain level code you should always try a bit harder not to break a case that was already working, because it really sucks when you end up with a broken toolchain because now reinstalling the working versions is non-trivial - I usually have to yell "I HAVE NO TOOLS BECAUSE I'VE DESTROYED MY TOOLS WITH MY TOOLS" at the monitor and then go for a smoke first when that happens.

When I make CPAN installs in the [local::lib](https://metacpan.org/pod/local::lib) style, I always use *self-advert!* [git ll-cpanm](https://github.com/mcast/git-yacontrib/blob/master/bin/git-ll-cpanm)

> This installs CPAN (Perl5) libraries into a local::lib directory, using cpanm or cpan.

I know there are other tools for maintaining old versions of installed code.  This one is mine, doesn't depend on Perl itself and I like it despite its rough edges.

I could destroy my tools with my tools, but the old ones are just a [git rhH ^](https://github.com/mcast/git-yacontrib/blob/master/bin/git-rhH) away...  which is `git reset --hard HEAD^` because I seem to write often enough to make a shortcut.
