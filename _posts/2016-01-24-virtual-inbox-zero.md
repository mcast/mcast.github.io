---
title: Virtual Inbox Zero
tags: inbox-zero lifehacks
copyright: CC0
last_modified_at: 2016-02-03 17:29:29 +0000
---

The idea of [Inbox Zero](http://www.43folders.com/izero) really appeals to me.  There are [many variations](https://duckduckgo.com/?q=inbox+zero), but...  it [can go wrong](http://www.newyorker.com/culture/culture-desk/zero-dark-inbox) and I'm not there yet.  What does this mean for me?

Well this isn't an introspection post, it's a method idea post:

1. I group mail into threads and sort them to put the most recently updated at the bottom[^1].
2. I send myself a mail with the subject `------------------------------ ( $n $date ) ------------------------------`, where `n` is the next message number in the inbox.
3. That is my Virtual Inbox Zero.
    * Messages after that may be new, or they're part of a thread attached to something new.  Better deal with them.
4. Messages above that are old.
    * They aren't growing.
    * They are still visible, scrollbar permitting.
    * Sure I need to deal with them one day...


[^1]: I use [mutt](http://www.mutt.org/) for this.  (See also [the manual](http://www.mutt.org/doc/manual/manual-6.html#sort_aux))

	```
	set sort=threads
	set sort_aux=last-date-received
	```

	This avoids the problem of getting a new mail on an old thread, and not seeing it; also solved by actually reaching Inbox Zero!

---
