---
title: I receive a lesson on Rust traits and generics
tags: rust
---

Complete with examples of how *not* to do it.

Edited for format, brevity, hyperlinks and ordering, from [#rust irc.mozilla.org 2015-07-13](https://botbot.me/mozilla/rust/2015-07-13/) by mcast.

## Traits being unsized; variable bindings

mcast:
> Hypothesis: variable bindings cannot hold trait-objects?  <https://github.com/mcast/markdown-chapterise/commit/926d91dc>
> I haven't seen it written in TRPL (though I paused reading to write), but several days' head banging suggests it is so

This page is here to explain how and why my hypothesis is incorrect.

steveklabnik:
> playbot: let x: &Display;

playbot:
```
<anon>:9:17: 9:24 error: use of undeclared type name `Display`
<anon>:9        let x: &Display;
output truncated; full output at: <http://bit.ly/1CC0rXA>
```

steveklabnik:
> oh right you need the full path

<i> Later: with the full path to [the `Display` trait](http://doc.rust-lang.org/stable/std/fmt/trait.Display.html), [this does compile](https://play.rust-lang.org/?code=%23![allow%28unused_variables%29]%0Ause%20std%3A%3Afmt%3A%3ADisplay%3B%0Afn%20show%3CT%3A%20std%3A%3Afmt%3A%3ADebug%3E%28e%3A%20T%29%20{%20println!%28%22{%3A%3F}%22%2C%20e%29%20}%0Afn%20main%28%29%20{%0A%20%20%20%20show%28{%0A%20%20%20%20%20%20%20%20let%20x%3A%20%26Display%3B%0A%20%20%20%20}%29%3B%0A}&version=stable), producing unit. </i>

Murarth:
> Trait objects are unsized. let bindings can't hold unsized types. They can hold references to unsized types. `Box<Trait>` may also be an option.

bluss:
> I'm not sure what you mean

steveklabnik:
> but yeah, binding should be able to hold a trait object

mcast:
> I had got this, though forgot to try refs.  Boxes seemed to squash some bugs, but they always bubbled up elsewhere..?

bluss:
> ah, found it, `let i2: Iterator<Item=String>`  yes this is not possible

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
> hmm, boxing works for this example [https://play.rust-lang.org/?code=use%20std%3A%3Avec%3A%3AIntoIter%3B%0Afn%20main%28%29%20{%0A%20%20%20%20let%20v%20%3D%20vec![2%2C4%2C6%2C8]%3B%0A%20%20%20%20let%20i%3A%20IntoIter%3Ci32%3E%20%3D%20v.into_iter%28%29%3B%0A%20%20%20%20let%20i2%3A%20Box%3CIterator%3CItem%3Di32%3E%3E%20%3D%20Box%3A%3Anew%28i%29%3B%0A%20%20%20%20for%20n%20in%20i2%20{%0A%20%20%20%20%20%20%20%20print!%28%22next%3A%20{}\n%22%2C%20n%29%3B%0A%20%20%20%20}%0A}%0A&version=nightly]() (even on stable, where I am) <i> [ but stable then was 1.1.0, and I had been using 1.0.0 for my tests ] </i>

bluss:
> yes that's expected

## Generics are not dynamic types

mcast:
> the earlier one, where I was getting (apparent) tautologies <https://github.com/mcast/markdown-chapterise/commit/5b48c728>

bluss:
> this is a common misunderstanding.  The return type [ when coded correctly ] corresponds to the exact type you will return.
> Generics doesn't give you any leeway to return something you didn't declare.  If you say MarkdownStream<T>, that's the type you need to return, not some particular type that impleements the same type that T does.  Exactly T is what you need to return.

bluss:
> ok first just two functions that add together things [http://is.gd/SLlk3a](https://play.rust-lang.org/?code=use%20std%3A%3Aops%3A%3AAdd%3B%0A%0Afn%20f%3CT%3A%20Add%3COutput%3DT%3E%3E%28x%3A%20T%2C%20y%3A%20T%29%20-%3E%20T%20{%0A%20%20%20%20x%20%2B%20y%0A}%0A%0Afn%20g%3CT%3A%20Add%3COutput%3DT%3E%3E%28x%3A%20T%2C%20y%3A%20T%29%20-%3E%20T%20{%0A%20%20%20%20panic!%28%29%0A}%0A%0A%0Afn%20main%28%29%20{%0A%0A%20%20%20%20println!%28%22{}%22%2C%20f%282%2C%202%29%29%3B%0A%20%20%20%20println!%28%22{}%22%2C%20g%282%2C%202%29%29%3B%0A}%0A&version=stable)
> your example is like changing the function `g` to this [http://is.gd/TdKXL0](https://play.rust-lang.org/?code=use%20std%3A%3Aops%3A%3AAdd%3B%0A%0Afn%20f%3CT%3A%20Add%3COutput%3DT%3E%3E%28x%3A%20T%2C%20y%3A%20T%29%20-%3E%20T%20{%0A%20%20%20%20x%20%2B%20y%0A}%0A%0Afn%20g%3CT%3A%20Add%3COutput%3DT%3E%3E%28x%3A%20T%2C%20y%3A%20T%29%20-%3E%20T%20{%0A%20%20%20%200%0A}%0A%0A%0Afn%20main%28%29%20{%0A%0A%20%20%20%20println!%28%22{}%22%2C%20f%282%2C%202%29%29%3B%0A%20%20%20%20println!%28%22{}%22%2C%20g%282%2C%202%29%29%3B%0A}%0A&version=stable)
> `0` is of a type (say `i32`) and it implements addition just fine but we can't return `0` from function `g`, we promised to return type `T`.  In effect a generic type parameter is *user chosen* regardless if it is used in input function arguments or just in *input* type parameters.

mcast: [ I collected mdslurp.rs and mdstream.rs ] <https://gist.github.com/anonymous/862e0f810673d396e516> <https://play.rust-lang.org/?gist=862e0f810673d396e516&version=stable>

bluss:
> I see your pastebinned code. `new_io` says it will return `MarkdownStream<T>` but it actually returns [ ~~peekable was already part of it~~ ] `MarkdownStream<Box<Iterator=String>>` so yes, it's a type mismatch.

mcast:
> wanted to convert a `( BufReader.lines() | vec![...].into_iter() )` into a stream of my objects

bluss:
> using `Box<Iterator>` may be entirely appropriate.  I'm only trying to explain stuff.

mcast:
> it made a lot of errors go away, but.. not all!

bluss:
> so are you ok with that you can't return `MarkdownStream<T>` from that method?

{% include div-WiP.html %}

mcast: I'm grateful for the explanations, yes, because they are what will prevent future head-banging in this area.  just not understanding them yet
bluss: mcast: what did you think of the f vs g examples
bluss: mcast: why you can't return 0 in a function declared as returning T
mcast: I need to go read about Add, but I'm inferring that it represents the operation-having-not-yet-run, not the result; so 0 is of a different type
bluss: Add is just the trait for the + operator


bluss: you say you will return a T, you try to return 0. 0 (type i32) implements the same traits..
nathan7: mcast: the caller gets to pick any T that implements Iterator<Item=String>
bluss: generics are not dynamic typing

bluss: mcast: well if you want to unify two types. I.e. you have two values of different types, and want to store them in something of one determined type, then boxed trait object is the way to go
bluss: mcast: if you want to "erase" the inner iterator type, as it seems, it's the way to go
mcast: ok, thanks - that is what I was trying to do.  Put in a File or some #[test] vec!, and suck out some MarkdownEle


bluss: mcast: and why did you patch to change from using generic iterators to a boxed trait object?

[34 minutes]

mcast: I was rattling around trying to make it work, seeing techniques that looked promising but not understanding them.Had previously tried type aliases and some other stuff
