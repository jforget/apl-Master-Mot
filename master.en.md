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


