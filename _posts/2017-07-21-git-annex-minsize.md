---
title: How much space in Git does a git-annex file use?
tags: git-annex git
copyright: CC0-quoting
last_modified_at: 2017-07-21 22:49:58 +0100
---

* When I store a file in [git annex](http://git-annex.branchable.com/), how much space does it use in the [Git](https://git-scm.com/) repository?
  * TL;DR about 400 packfile bytes/file at scale, plus another 100 per `copy` or `drop` until [`git annex forget`](https://git-annex.branchable.com/git-annex-forget/).
* What is a sensible value for [`annex.largefiles`](https://git-annex.branchable.com/tips/largefiles/)?


## The experiment

1. Make an empty git annex repository
2. Gathering disk usage and other repository size information after each change,
  1. Add small files in batches of 1000
  2. Copy to a special remote
3. Draw graphs

## What does it look like?

* While adding the tiny files in batches of 1000, it looks so linear it's dull
  [![](/assets/2017-git-annex-minsize/add-files.png)](/assets/2017-git-annex-minsize/add-files.png)
* Dividing the size of the packfile by number of files gives a size per file.  As the number of files increases this shows an asymptotic decrease in _packfile bytes cost per file_,
  [![](/assets/2017-git-annex-minsize/per-file.png)](/assets/2017-git-annex-minsize/per-file.png)
* With 50k files present, adding or removing a copy of all files also looks fairly linear
  [![packfile bytes per file, one copy vs. increasing numbers of files](/assets/2017-git-annex-minsize/copy-cost.png)](/assets/2017-git-annex-minsize/copy-cost.png)  
  The return to three copies would not look out of place if it were mirrored over to five copies.
* Files also take fewer bytes per copy when there are more copies
  [![packfile bytes per file, one copy vs. increasing numbers of files](/assets/2017-git-annex-minsize/copy-extra-cost.png)](/assets/2017-git-annex-minsize/copy-extra-cost.png)  
  There is probably room for more experiments here, but it is enough for me.


## Configuration to store files efficiently?

* In the case of changing sensibly sized text files, plain Git does a great job.
* For write-once files which gzip to over 400 bytes,
  * it might be worth putting them in the annex, so you can choose to not have them available
  * you still have to pay for the symlink checkout (probably rounds up to 4 KiB)
  * file checkouts probably also round up to 4 Kib
  * files present in the annex also have three levels of directory above (probably 4 KiB each), two of which will be shared when many files are present

I haven't made or tested settings for [`annex.largefiles`](https://git-annex.branchable.com/tips/largefiles/) yet, or considered what sort of experiment to run.


## Are the simplifications realistic?

* Using very small files like `"$n\n"` on `backend=SHA256E`
  * These keys contain the length, which is .  For longer files, 
* With no chunking or URLs?
  * `git annex` can store other things with the log, which are not tested here
* Running the add/copy/drop operations close together in time
  * This allows the integer part of the timestamps to compress better - you may pay some extra bytes for operations spread across years.
  * The nanoseconds are probably still just noise in any case.

Other caveats,

* Sizes are for one aggressively repacked packfile.  When there are loose objects or multiple packfiles, total size will be larger.


## How did you do it?

Or "Can I repeat the experiment?"

I did it with some grubby shellscripts, Perl and filled in the gaps
with paste-from-the-documentation oneliners.

Here is [the git bundle of it](/assets/2017-git-annex-minsize/git-annex-minsize.bundle).

---
