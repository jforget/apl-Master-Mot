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
∇ r ← master∆slurp path
r ← ⎕FIO[26] path
∇
master∆nl ← "\n"
∇ master∆extract path; v; n; t; sel
v ← master∆slurp path
n ← ⍴ v
t ← ((⍳n) ⌽ (2⍴n) ⍴ v)[;⍳9]
sel ← (master∆nl = t[;1]) ∧ (' ' = t[;7]) ∧ master∆nl = t[;9]
t ← t[sel/⍳n;]
prop  ← t[;1 + ⍳5]
notes ← ⍎,t[;7 8]
∇
