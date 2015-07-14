---
title: I receive a lesson on Rust traits and generics
tags: rust-lang
---

Text from the fine folks at [#rust irc.mozilla.org 2015-07-13](https://botbot.me/mozilla/rust/2015-07-13/), edited for format, brevity, hyperlinks and ordering.

Complete with examples of how *not* to do it.

## Traits being unsized; variable bindings

mcast:

> Hypothesis: variable bindings cannot hold trait-objects?  <https://github.com/mcast/markdown-chapterise/commit/926d91dc>
> I haven't seen it written in TRPL (though I paused reading to write), but several days' head banging suggests it is so

This page is here to explain how and why **my hypothesis above is incorrect**.

steveklabnik:

> playbot: let x: &Display;

playbot:

> ~~~ console
> <anon>:9:17: 9:24 error: use of undeclared type name `Display`
> <anon>:9        let x: &Display;
> output truncated; full output at: <http://bit.ly/1CC0rXA>
> ~~~

steveklabnik:

> oh right you need the full path
> but yeah, binding should be able to hold a trait object

<i> Later: with the full path to [the `Display` trait](http://doc.rust-lang.org/stable/std/fmt/trait.Display.html), [this does compile](http://is.gd/iuIcyb), producing unit.[^disp] </i>

Murarth:

> Trait objects are unsized. let bindings can't hold unsized types. They can hold references to unsized types. `Box<Trait>` may also be an option.

mcast:

> I had got this, though forgot to try refs.  Boxes seemed to squash some bugs, but they always bubbled up elsewhere..?

bluss:

> [...] found it, `let i2: Iterator<Item=String>`  yes this is not possible

mcast:

> I can put a `vec![2,4,6,8].into_iter()` in [ a let binding ], but not if I declare it to be `Iterator<Item=i32>`.  The compiler never came out and told me straight, so I persisted.  Should TRPL have told me?

bluss:

> there are some types in rust that must be accessed behind a pointer.  The dynamically sized types
> just `TraitName` is the object type of a trait so you'd use `Box<TraitName>` or just `&mut TraitName` (or `&TraitName`, or `Rc<TraitName>`...)

nathan7:

> does `Rc<Trait>` work now?

bluss:

> fully supported from Rust 1.2

nathan7:

> SWEEET

bluss:

> a bit broken in rust 1.1 maybe
> oh and by fully supported.. some pieces might be missing

mcast:

> hmm, boxing works for this example <http://is.gd/mtzZG8>[^boxiter] (even on stable, where I am) <i> [ but stable then was 1.1.0, and I had been using 1.0.0 for my tests ] </i>

bluss:

> yes that's expected

[^disp]:
	~~~ rust
	#![allow(unused_variables)]
	use std::fmt::Display;
	fn show<T: std::fmt::Debug>(e: T) { println!("{:?}", e) }
	fn main() {
	    show({
	        let x: &Display;
	    });
	}
	~~~

[^boxiter]:
	~~~ rust
	use std::vec::IntoIter;
	fn main() {
	    let v = vec![2,4,6,8];
	    let i: IntoIter<i32> = v.into_iter();
	    let i2: Box<Iterator<Item=i32>> = Box::new(i);
	    for n in i2 {
	        print!("next: {}\n", n);
	    }
	}
	~~~

## Generics are not dynamic typing

mcast:

> the earlier one, where I was getting (apparent) tautologies <https://github.com/mcast/markdown-chapterise/commit/5b48c728>

bluss:

> this is a common misunderstanding.  The return type [ when coded correctly ] corresponds to the exact type you will return.
> Generics doesn't give you any leeway to return something you didn't declare.  If you say `MarkdownStream<T>`, that's the type you need to return, not some particular type that impleements the same type that `T` does.  Exactly `T` is what you need to return.

### Small example with `Add`

"The [`Add` trait](http://doc.rust-lang.org/stable/std/ops/trait.Add.html) is used to specify the functionality of `+`".  It defines a method signature `add` by which instances may be added, and returns a specified type.

bluss:

> ok first just two functions that add together things <http://is.gd/SLlk3a>[^addf]
> your example is like changing the function `g` to this <http://is.gd/TdKXL0>[^addg]
> `0` is of a type (say `i32`) and it implements addition just fine but we can't return `0` from function `g`, we promised to return type `T`.  In effect a generic type parameter is *user chosen* regardless if it is used in input function arguments or just in *input* type parameters.

[^addf]:
	~~~ rust
	use std::ops::Add;
	
	fn f<T: Add<Output=T>>(x: T, y: T) -> T {
	    x + y
	}
	
	fn g<T: Add<Output=T>>(x: T, y: T) -> T {
	    panic!()
	}
	
	
	fn main() {
	
	    println!("{}", f(2, 2));
	    println!("{}", g(2, 2));
	}
	~~~

[^addg]:
	~~~ rust
	use std::ops::Add;
	
	fn f<T: Add<Output=T>>(x: T, y: T) -> T {
	    x + y
	}
	
	fn g<T: Add<Output=T>>(x: T, y: T) -> T {
	    0
	}
	
	
	fn main() {
	
	    println!("{}", f(2, 2));
	    println!("{}", g(2, 2));
	}
	~~~

[...]

> you say you will return a `T`, you try to return `0`. `0` (type `i32`) implements the same traits..

but `i32` is not `T`.

### My code with the original problem

There are several versions of this in the commit history alone, but I collected [`mdslurp.rs` and `mdstream.rs`](https://github.com/mcast/markdown-chapterise/commit/5b48c728) to <https://gist.github.com/anonymous/862e0f810673d396e516> == <https://play.rust-lang.org/?gist=862e0f810673d396e516&version=stable>.  The first error is what surprised me,

~~~ console
$ cargo test
   Compiling markdown-chapterise v0.0.1 (file:///Users/mca/gitwk-github/markdown-chapterise)
src/mdstream.rs:29:9: 29:61 error: mismatched types:
 expected `mdstream::MarkdownStream<T>`,
    found `mdstream::MarkdownStream<core::iter::Iterator<Item=collections::string::String>>`
(expected type parameter,
    found trait core::iter::Iterator) [E0308]
src/mdstream.rs:29         MarkdownStream { input: Box::new(lines.peekable()) }
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/mdstream.rs:29:9: 29:61 error: the trait `core::marker::Sized` is not implemented for the type `core::iter::Iterator<Item=collections::string::String>` [E0277]
src/mdstream.rs:29         MarkdownStream { input: Box::new(lines.peekable()) }
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/mdstream.rs:29:9: 29:61 note: `core::iter::Iterator<Item=collections::string::String>` does not have a constant size known at compile-time
src/mdstream.rs:29         MarkdownStream { input: Box::new(lines.peekable()) }
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[...]
~~~

* [E0308](https://doc.rust-lang.org/error-index.html#E0308)
* [E0277](https://doc.rust-lang.org/error-index.html#E0277)

bluss:

> I see your pastebinned code. `new_io` says it will return `MarkdownStream<T>` but it actually returns [ <del> peekable was already part of it </del> ] `MarkdownStream<Box<Iterator=String>>` so yes, it's a type mismatch.

Just because `T` could only be the type `Box<Iterator<Item=String>>`, doesn't mean I can remove the caller's right to choose `T`.  They are not the same thing at compile time, and runtime type equality is simply too late to be relevant.

nathan7:

> the caller gets to pick any `T` that implements `Iterator<Item=String>`


## Summary

bluss:

* if you want to unify two types, I.e. you have two values of different types, and want to store them in something of one determined type, then boxed trait object is the way to go.
* if you want to "erase" the inner iterator type, as it seems, it's the way to go

* generics are not dynamic typing

mcast:

> ok, thanks - that is what I was trying to do.  Put in a `File` or some `#[test] vec!`, and suck out some `MarkdownEle`
