-*- encoding: utf-8; indent-tabs-mode: nil -*-

# Master Word

## `master∆license`

The  text part  of  this repository  is licensed  under  the terms  of
Creative  Commons, with  attribution and  share-alike (CC-BY-SA).  The
code part of  this repository is licensed with the  GPL version 1.0 or
later.


As  required  by the  GPL,  each  file with  code  must  start with  a
one-description line of  the program and the summary of  the GPL. Here
it is.


```
∇ master∆license
'APL program to solve a Master Mot quizz'
''
'Copyright (C) 2025 Jean Forget  (JFORGET at cpan dot org)'
''
'Build date:'
''
'Portability: L3 (reading text files)'
''
' This program is distributed under the GNU Public License version 1 or later'
''
' You can find the text of the license in the LICENSE file or at'
' http://www.gnu.org/licenses/gpl-1.0.html.'
''
' Here is the summary of GPL:'
''
' This program is free software; you can redistribute it and/or modify'
' it under the terms of the GNU General Public License as published by'
' the Free Software Foundation; either version 1, or (at your option)'
' any later version.'
''
' This program is distributed in the hope that it will be useful,'
' but WITHOUT ANY WARRANTY; without even the implied warranty of'
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the'
' GNU General Public License for more details.'
''
' You should have received a copy of the GNU General Public License'
' along with this program; if not, write to the Free Software Foundation,'
' Inc., <http://www.fsf.org/>.'
∇
```

As  you can  see,  this summary  is executable  code  included in  the
software.  So, after  you have  logged into  APL and  initialised your
workspace with my script, you can display this summary at any moment.


## Description

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

Solution :


```
coude
```

All  codes from  the problem  are  valid French  words. Likewise,  the
solution is  a French word.  In some rare  cases, the problem  has two
solutions, one of which is a valid French word and the other is just a
meaningless lump of  5 letters. In this case, my  program extracts the
two (or more) solutions and it is  up to the user to select the proper
one.

The magazine gives a  detailed solution, with step-by-step deductions.
With the example above, the solution compares code <tt>paume</tt> with
<tt>palme</tt> and concludes that the letter  at position 3 is "u". My
program does  not work that way.  It makes an extensive  search of all
possible  codes. Nearly  extensive,  because it  generates all  1-char
partial  codes, filters  the list,  builds all  2-char partial  codes,
filters again and so on.


## Usage

To solve a problem,  the first step is typing it in  a text file. Each
line begins  with the 5-char proposition.  It is followed by  a single
space (no more) and ends with the 1-digit mark. Nothing more. The line
separator is LF, <tt>U+000A</tt>, as with any standard Unix text file.

The lines that do not match the pattern 5 + space + digit are ignored.
This allows you to add technical lines as below.


```
-*- encoding: utf-8; indent-tabs-mode: nil -*-

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

You may use lower-caps letters in  a first file and upper-caps letters
in  another file,  but  do not  mix  them  in the  same  file. As  for
diacritics, do not use them  (see <tt>foret</tt> in the example above,
which corresponds to the French word "forêt").


## The programs

To write these programs,  I have used the old variant  of APL, which I
learnt in the early 1980's, before the advent of "disclose", "enclose"
and "each" (<tt>⊃⊂¨</tt>). Thus, a string is a vector of chars, and an
array of strings  is a rectangular table of chars  (which implies that
all strings must have the same length).

Likewise, I use the
<a href='https://www.gnu.org/software/apl/Library-Guidelines.html'>codification</a>
that I was advised to use when I wrote my
<a href='https://github.com/jforget/apl-calendar-french'>French Revolutionary calendar program</a>
even if I have no intention to publish my Master Mot program on
<a href='https://www.gnu.org/software/apl/Bits_and_Pieces/'>APL bits and pieces</a>.


### `master∆slurp` - Loading a file

This function aims to extract the content of a file and load it into a
char vector. This  function is not portable.  The implementation below
works  only with  GNU-APL. Its  name  comes from  the (standard)  Raku
function with the same purpose.

The  function receives  one parameter,  a string  (char vector)  which
contains the path to the text file. This can be a relative or absolute
path, it does not matter. The  function result is another char vector,
holding the whole content of the text file.


```
∇ r ← master∆slurp path
r ← ⎕FIO[26] path
∇
```

### Loading the problem

Let us use a file containing this text


```
aaaa 1
bbbb 0
```

Its inner structure is a linear sequence of characters


```
aaaaa(SP)1(LF)bbbbb(SP)0(LF)
```

The  program  begins with  generating  a  "rotating" array  from  this
sequence


```
aaaaa(SP)1(LF)bbbbb(SP)0(LF)
aaaa(SP)1(LF)bbbbb(SP)0(LF)a
aaa(SP)1(LF)bbbbb(SP)0(LF)aa
aa(SP)1(LF)bbbbb(SP)0(LF)aaa
a(SP)1(LF)bbbbb(SP)0(LF)aaaa
(SP)1(LF)bbbbb(SP)0(LF)aaaaa
1(LF)bbbbb(SP)0(LF)aaaaa(SP)
(LF)bbbbb(SP)0(LF)aaaaa(SP)1
bbbbb(SP)0(LF)aaaaa(SP)1(LF)
bbbb(SP)0(LF)aaaaa(SP)1(LF)b
bbb(SP)0(LF)aaaaa(SP)1(LF)bb
bb(SP)0(LF)aaaaa(SP)1(LF)bbb
b(SP)0(LF)aaaaa(SP)1(LF)bbbb
(SP)0(LF)aaaaa(SP)1(LF)bbbbb
0(LF)aaaaa(SP)1(LF)bbbbb(SP)
(LF)aaaaa(SP)1(LF)bbbbb(SP)0
```

Actually,  if using  <tt>⍳n</tt> to  roll  the array,  with the  index
origin <tt>⎕IO</tt> equal to 1, the rolling array will be rather


```
aaaa(SP)1(LF)bbbbb(SP)0(LF)a
...
(LF)aaaaa(SP)1(LF)bbbbb(SP)0
aaaaa(SP)1(LF)bbbbb(SP)0(LF)
```

with the  original sequence  at the end  of the array  and not  at its
beginning.

Then the program truncates these sequences to 9 chars.


```
aaaa(SP)1(LF)bb
aaa(SP)1(LF)bbb
aa(SP)1(LF)bbbb
a(SP)1(LF)bbbbb
(SP)1(LF)bbbbb(SP)
1(LF)bbbbb(SP)0
(LF)bbbbb(SP)0(LF)
bbbbb(SP)0(LF)a
bbbb(SP)0(LF)aa
bbb(SP)0(LF)aaa
bb(SP)0(LF)aaaa
b(SP)0(LF)aaaaa
(SP)0(LF)aaaaa(SP)
0(LF)aaaaa(SP)1
(LF)aaaaa(SP)1(LF)
aaaaa(SP)1(LF)b
```

Then, the  program filters this  list to keep only  sequences starting
with a (LF) and ending with another (LF).


```
(LF)bbbbb(SP)0(LF)
(LF)aaaaa(SP)1(LF)
```

Lastly, the program extract the array of 5-char codes and the array of
marks.


```
bbbbb
aaaaa
---
0 1
```

The  propositions are  not  in the  original order,  but  it does  not
matter. What  matters is that this  order must be consistent  with the
order of the array of marks.

You may  have noticed that  if the file  contains a single  line, this
line will  not be extracted,  because it will never  be simultaneously
preceded and followed by a (LF).  But seriously, can you have a Master
Mot problem consisting of a single line?


#### `master∆nl` - Unportable NL (or LF) char

I do  not know how  I can enter  a NL (or LF)  char in a  portable APL
program. I admit that I have not  searched for very long. On the other
hand, using  a NL is  easy when  using GNU-APL, I  just have to  use a
double-quoted string litteral. I isolate this lack of portability in a
unique program line.


```
master∆nl ← "\n"
```

#### `master∆extract` - Extracting the problem data

The program  receives the pathname of  the problem file and  feeds two
global variables <tt>prop</tt> and  <tt>notes</tt>. There is no return
value.

Loding the content of the file.


```
∇ master∆extract path; v; n; t; sel
v ← master∆slurp path
```

Generating the rolling array and truncating it to 9 columns


```
n ← ⍴ v
t ← ((⍳n) ⌽ (2⍴n) ⍴ v)[;⍳9]
```

The program filters the list to  select line vectors with LF in colums
1 and 9 and SP in column 7.


```
sel ← (master∆nl = t[;1]) ∧ (' ' = t[;7]) ∧ master∆nl = t[;9]
t ← t[sel/⍳n;]
```

The program extract the propositions  and their notes. When extracting
the notes, the program takes also  the preceding space. If the program
does not take this space, the result  would be a string of digits with
no separator and  the dequote operator would generate  a single number
with  <i>n</i> digits.  If we  do not  use the  dequote operator,  the
<tt>notes</tt> variable would contain a vector of chars, while we need
a vector of numbers.


```
prop  ← t[;1 + ⍳5]
notes ← ⍎,t[;7 8]
∇
```

### Generating the various possible codes

#### `master∆letters` - Letters used at column <i>n</i>

In Master  Mot, all  letters of  the solution appear  in at  least one
proposition,  at the  proper column.  So we  need to  extract all  the
letters that appear  in column <i>n</i>. For this,  the program begins
with extracting the whole column.


```
∇ r ← master∆letters n; col
col ← prop[;n]
```

But there are duplicates and we  need to eliminate them. For this, the
program sorts the letters.


```
col ← col[⍋col]
```

Then it checks  each character, to determine if this  char is followed
by the same char. In this case, the char is removed from the list.

Actually, the logic is inverted.  The program checks each character to
determine if  it is followed  by a different  char. In this  case, the
char is kept.


```
r ← (col ≠ 1 ⌽ col) / col
∇
```

Remark. If column <i>n</i> contains <var>x</var> instances of the same
character,  the function  will return  an  empty vector  instead of  a
1-char vector.  This will never happen  in a real Master  Mot problem.
Therefore, we disregard this bug.


#### Generating the possible codes with length <var>n</var>

To generate  the possible codes  with <var>n</var> chars,  the program
begins with the list of possible codes with <var>n</var> - 1 chars and
concatenate them with the chars from <tt><a href='#master∆letters' class='call'>master∆letters</a> n</tt>.

Because  of the  way  <tt><a href='#master∆letters' class='call'>master∆letters</a></tt> works,  its result  is
sorted. Therefore the 1-char possible codes are sorted. We try to keep
this property with the <var>n</var>-char possible codes

Let us suppose that the 3-char possible codes are


```
abc
def
ghi
```

and that the (sorted) list of letters for column 4 is


```
wxyz
```

The expected result is:


```
abcw
abcx
abcy
abcz
defw
defx
defy
defz
ghiw
ghix
ghiy
ghiz
```

For this, we index the list of 3-char possible codes with


```
1 1 1 1 2 2 2 2 3 3 3 3
```

that is,  numbers 1 to  3 (because 3  possible codes) repeated  4 times
(because 4  added letters) and at  the same time we  index the column-4
letters with


```
1 2 3 4 1 2 3 4 1 2 3 4
```

that is, numbers 1 to 4  (because 4 letters) repeated 3 times (because
3 possible codes in the previous generation).


#### `master∆generation`

How many possible codes and how many new letters?


```
∇ r ← poss master∆generation letters; np; nl; ip; il
np ← ¯1 ↓ ⍴ poss
nl ← ⍴ letters
```

Indexing the possible codes and the letters.


```
ip ← (np × nl) ⍴ ⍳ np
il ← (np × nl) ⍴ ⍳ nl
ip ← ip[⍋ip]
```

Concatenating the possible codes from the previous generation with the
new letters.


```
r ← poss[ip;] , letters[il]
∇
```

### Computing the note for a proposition

If both parameters  are 5-char codes, no problem to  compute the note.
The program  compares the corresponding  chars in both  strings, which
gives a vector with 5 boolean  values. Then we add these boolean value
(converted to integers 0 or 1) and this is the final result.

If both  parameters are  strings, but  one of them  is shorter  than 5
chars, the  program must truncate the  longer string to the  length of
the shorter one. Then the char-wise  comparison is possible and we can
convert the booleans to integers and add them.

If both parameters  are lists of strings, that  is, rectangular arrays
of chars,  the computation of the  note must be some  kind of external
product.  For  instance,   if  we  have  8  possible   codes  with  10
propositions,  then the  result  must  be an  array  of integers  with
dimension <tt>⍴ = (8 10)</tt>.

Suppose the <tt>prop</tt> variable contains


```
pouce
index
coude
```

and the <tt>poss</tt> variable contains


```
col
cou
pou
```

then the result of <tt>poss master∆note prop</tt> will be


```
.     pouce index coude
col :   1     0     2
cou :   2     0     3
pou :   3     0     2
```

In  an abstract  fashion, using  <tt>master∆note</tt> on  a vector  of
possible codes and on a vector  of proposition gives an array <tt>poss
∘.note prop</tt> with an  external product (<i>jot</i>). Actually, the
vector of possible  codes is an array  of chars with <tt>⍴  = 3 3</tt>
and, after truncation  the vector of propositions is also  an array of
chars with <tt>⍴ = 3 3</tt>. The computation of the notes is therefore
done with an internal product <tt>+.=</tt>


```
.     p   i   c
.     o   n   o
.     u   d   u
.
col   1   0   2
cou   2   0   3
pou   3   0   2
```

#### `master∆note`

Compute the dimension to truncate both parameters.


```
∇ r ← poss master∆note prop; d1; d2; l1; l2; lmin; posst; propt
l1   ← ¯1 ↑ d1 ← ⍴ poss
l2   ← ¯1 ↑ d2 ← ⍴ prop
lmin ← l1 ⌊ l2
d1   ← (¯1 ↓ d1), lmin
d2   ← (¯1 ↓ d2), lmin
```

Truncating  the  possible codes  and  the  propositions to  the  lower
dimension.  At  the  same  time, the  program  transposes  the  second
parameter, so it will be ready for the internal product.


```
posst ←   d1 ↑ poss
propt ← ⍉ d2 ↑ prop
```

Compute the array of notes.


```
r ← posst +.= propt
∇
```

### `master∆filter` - Sifting through the list of possible codes

A  partial code  is compatible  with a  proposition if  both following
conditions are fulfilled:

<ol>
<li>The assigned note is lower than or equal to the proposition's final note.</li>

<li>The assigned  note is greater  than or equal to  the proposition's
final note minus the number of still empty slots. That means that even
if the filling of each empty slot  brings a new black mark, we are too
much behind to reach the final note.</li>

</ol>

Example. The proposition is <tt>'pouce'</tt>  with a final note 3. The
program checks the truncated code <tt>'ro'</tt>. Its note is 1 and the
number of empty slots is 3. Since note 1 is lower than or equal to the
final note 3, and since it is  greater than or equalt to the result of
3-3 (final  note - empty  slots), the truncated code  <tt>'ro'</tt> is
compatible.

Now  we check  possible code  <tt>'rif'</tt>. Its  note is  0 and  the
number of  empty slots is  2. On  one hand the  note is lower  than or
equal to the final note 3, but on  the other hand it is lower than the
difference 3-2 (final note -  empty slots). Code <tt>'rif'</tt> is not
compatible.

A last example is code  <tt>'pouc'</tt>. It is not compatible, because
its note is 4, which is greater than the final note 3.

Now, let us  examine how filtering work with a  list of possible codes
against a list of propositions. We use the following examples.


<pre>
coupe 4
paume 2
choux 1
      coupe paume choux
cou :   3     1     1
cha :   1     0     2
phi :   0     1     1
</pre>


Checking the first condition will be


<pre>
( 1   1   1 )       ( 3   1   1 )       ( 4   2   1 )
( 1   1   0 )   ←   ( 1   0   2 )   ≤   ( 4   2   1 )
( 1   1   1 )       ( 0   1   1 )       ( 4   2   1 )
</pre>


Checking the second condition will be


<pre>
( 1   1   1 )       ( 3   1   1 )       ( 2   0   ¯1 )
( 0   1   1 )   ←   ( 1   0   2 )   ≥   ( 2   0   ¯1 )
( 0   1   1 )       ( 0   1   1 )       ( 2   0   ¯1 )
</pre>


As you can  see in this example, the propositions'  notes (vector with
dimension 3) must  be reorganised as a 3×3 array:  1 line per possible
code, 1 column per proposition.


```
∇ r ← master∆filter poss; empty; npr; dim; sel1; sel2; sel
empty ← 5 - ¯1 ↑ ⍴ poss
dim   ← ⍴ npr ← poss master∆note  prop
sel1  ← npr ≤ dim ⍴ notes
sel2  ← npr ≥ (dim ⍴ notes) - empty
sel   ← ∧ / sel1, sel2
r ← sel ⌿ poss
∇
```

