-*- encoding: utf-8; indent-tabs-mode: nil -*-

WHAT?
=====

The  French  magazine  "Télé  7 Jeux"  provides,  among  others,  game
problems inspired from Mastermind.  These problems use 5-letter French
words. Contrary to standard Mastermind,  no white marks are earned for
letters appearing at the wrong place, only black marks are received.

Example

```
paume 2
choux 1
pends 1
foret 1
palme 1
fendu 1
phase 1
pente 1
curry 1
alors 0
```

Solution:

```
coude
```

WHY?
====

Because  these problems  are rather  tedious without  the help  from a
computer program. So  I wrote a few programs  in "vanilla" programming
languages (Lua, Raku),  with embedded loops. Yet, it is  much more fun
to write a loopless APL program (or nearly loopless), which deals with
arrays as a whole, without iterating on their elements.

The various programs in this repository are licensed GPL version 1.0
or later.  See the `LICENSE` file in this repository.

The various texts of this repository are licensed under the terms of
Creative Commons, with attribution and share-alike (CC-BY-SA).

WHO?
====

I, me, myself, Jean Forget

If you want  to contact me, just  remember that I have  a user-code in
CPAN. And somewhere in CPAN's website, you will find my email address.

WHERE? WHEN? HOW?
=================

Read a  more verbose version in  the HTML file `master.en.html`  or in
the Markdown file `master.en.md`.
