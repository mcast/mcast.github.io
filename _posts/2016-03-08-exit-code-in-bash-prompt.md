---
title: Exit code display in Bash prompt
tags: lifehacks
copyright: CC0
last_modified_at: 2016-03-08 12:00:27 +0000
---

## The normal Bash prompt

The standard Bash prompt looks like

```bash
bob@bobsbox:~$ echo $PS1
\u@\h:\w\$ 
```

or on a Debian based system, it also has the handy hackable prefix indicator

```bash
bob@bobsbox:~$ debian_chroot='boxed in'
(boxed in)bob@bobsbox:~$ echo $PS1
${debian_chroot:+($debian_chroot)}\u@\h:\w\$ 
```

## Did I break it?

With the normal Bash prompt, it's hard to tell when the previous command broke if it doesn't give a meaningful error message.

```bash
(boxed in)bob@bobsbox:~$ true
(boxed in)bob@bobsbox:~$ false
(boxed in)bob@bobsbox:~$ 
```

so I like to change mine,

```bash
(boxed in)bob@bobsbox:~$ debian_chroot=
bob@bobsbox:~$ PS1='${?/#0/\u}@\h:\w\$ '
bob@bobsbox:~$ false
1@bobsbox:~$ true
bob@bobsbox:~$ 
```

It can even take a splash of colour,

```bash
bob@bobsbox:~$ PS1='\[\e[31m\]${?/#0/\[\e[00m\]\u}@\h\[\e[00m\]:\w\$ '
bob@bobsbox:~$ false
1@bobsbox:~$ true
bob@bobsbox:~$ 
```
...though how I convince Markdown to render the red `1@bobsbox` in a fenced code block is mystery for another day.

## See also

* I also wrote and use [psst (Prompt String Setting Tool)](https://github.com/mcast/psst), a low-overhead tool to tell me when `$PERL_LOCAL_LIB_ROOT` is set for [local::lib](https://metacpan.org/pod/local::lib).
* Bash manual, [Controlling the Prompt](https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html)
* [Custom Bash prompt is overwriting itself](http://stackoverflow.com/a/19501528)

---
