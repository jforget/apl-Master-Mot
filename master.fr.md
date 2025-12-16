-*- encoding: utf-8; indent-tabs-mode: nil -*-

# Master mot

## `master∆license`

La  partie texte  de  ce  dépôt git  est  distribuée  sous la  licence
Creative Commons avec attribution et partage dans les mêmes conditions
(CC-BY-SA). La partie code de ce  dépôt est distribuée sous la licence
GPL version 1.0 ou ultérieure.


Ainsi  que le  requiert  la licence  GPL, tout  fichier  de code  doit
commencer par un  commentaire décrivant de façon  sommaire le logiciel
et résumant la GPL. La description sommaire en français&nbsp;:

«&nbsp;Les fonctions de  ce script permettent de  résoudre un problème
de Master Mot extrait de Télé 7 Jeux.&nbsp;»

Quant au résumé de la GPL, le  voici, en anglais (je ne suis pas assez
calé pour traduire en français un texte de teneur juridique).


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

Comme  vous pouvez  le deviner,  ce résumé  fait partie  intégrante du
logiciel. Donc,  une fois que  vous êtes entrés  sous APL et  que vous
avez initialisé votre espace de travail avec mon script, vous pouvez à
tout moment afficher ce résumé.


## Description

La revue "Télé  7 Jeux" propose, entre autres,  des problèmes inspirés
du  Mastermind  et  portant  sur  des  mots  français  de  5  lettres.
Contrairement au Mastermind  standard, il n'y a pas  de marque blanche
pour  les  lettres qui  apparaissent  dans  la  solution à  une  place
incorrecte. Seules les marques noires sont comptabilisées.

Exemple


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

Tous  les codes  proposés sont  des mots  de la  langue française.  La
solution elle  aussi est un  mot de  la langue française.  Parfois, le
problème a  deux solutions, dont un  mot de la langue  française et un
groupe de  cinq lettres  sans aucune  signification. Mon  programme ne
tient pas  compte de cette  propriété, il donne  dans ce cas  les deux
solutions et c'est à l'utilisateur de faire le tri.

Le  magazine  donne  une   solution  détaillée,  avec  les  déductions
successives. Par exemple, en comparant la ligne <tt>paume</tt> avec la
ligne <tt>palme</tt>, nous remarquons que  la lettre en position 3 est
un  «&nbsp;u&nbsp;».  Mon  programme  ne   cherche  pas  à  faire  des
déductions, il  effectue une recherche exhaustive  de la combinatoire.
Enfin, presque  exhaustive. Il commence  par créer la liste  des codes
partiels à 1  caractère, filtre cette liste, puis génère  la liste des
codes partiels à 2 caractères, filtre cette nouvelle liste et ainsi de
suite.


