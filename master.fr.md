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


## Utilisation

Pour résoudre  un problème, il  faut commencer par écrire  ce problème
dans  un  fichier  texte.  Chaque  ligne  de  texte  commence  par  la
proposition, 5 caractères,  puis un espace (pas plus), puis  la note à
un  chiffre.  Rien  de  plus.  Le  séparateur  de  ligne  est  le  LF,
<tt>U+000A</tt>, comme le standard UNIX.

Les lignes qui ne  se conforment pas au modèle 5 +  espace + note sont
ignorées. Cela permet  d'ajouter des lignes techniques  comme dans cet
exemple.


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

Vous pouvez  utiliser des  lettres majuscules dans  un fichier  et des
lettres minuscules dans un autre fichier.  Mais ne les mélangez pas au
sein  d'un  même  fichier.  Quant  aux  écrans,  trémas  et  cédilles,
oubliez-les (cf <tt>foret</tt> dans l'exemple ci-dessus).


## Les programmes

Pour écrire  les programmes, j'ai  utilisé la variante d'APL  que j'ai
apprise  dans les  années 1980,  avant l'apparition  des fonctions  <i
lang='en'>disclose</i>,     <i     lang='en'>enclose</i>     et     <i
lang='en'>each</i>  (<tt>⊃⊂¨</tt>). Une  chaîne de  caractères est  en
fait un  vecteur de caractères, un  vecteur de chaînes est  en fait un
tableau de caractères (ce qui implique que toutes les chaînes aient la
même longueur).

Également, j'utilise  la
<a href='https://www.gnu.org/software/apl/Library-Guidelines.html'>codification</a>
qui m'a été  conseillée lorsque j'ai écrit mon
<a href='https://github.com/jforget/apl-calendar-french'>programme de conversion de calendrier républicain</a>
même si je n'ai pas l'intention de publier mon programme de Master Mot sur
<a href='https://www.gnu.org/software/apl/Bits_and_Pieces/'>APL bits and pieces</a>.


### `master∆slurp` - Chargement du fichier

Cette  fonction  sert  à  charger   un  fichier  dans  un  vecteur  de
caractères.  Elle  n'est  pas   portable.  La  version  ci-dessous  ne
fonctionne  que  sur GNU-APL.  Son  nom  est  inspiré de  la  fonction
(standard) Raku qui effectue la même tâche.

La fonction reçoit  en paramètre une chaîne de  caractères (un vecteur
de caractères) contenant le chemin du  fichier texte à lire. Le chemin
peut  être relatif  ou absolu,  peu  importe. La  fonction renvoie  un
vecteur de caractères représentant le contenu du fichier texte.


```
∇ r ← master∆slurp path
r ← ⎕FIO[26] path
∇
```

### Chargement du problème

Soit un fichier contenant le texte


```
aaaa 1
bbbb 0
```

De manière interne, c'est une suite linéaire de caractères


```
aaaaa(SP)1(LF)bbbbb(SP)0(LF)
```

Le programme  commence par générer un  tableau «&nbsp;rotatif&nbsp;» à
partir de cette suite de caractères.


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

En fait,  de la façon  dont APL fonctionne, en  utilisant <tt>⍳n</tt>
pour la  rotation avec une origine  des indices <tt>⎕IO</tt> à  1, le
tableau sera plutôt


```
aaaa(SP)1(LF)bbbbb(SP)0(LF)a
...
(LF)aaaaa(SP)1(LF)bbbbb(SP)0
aaaaa(SP)1(LF)bbbbb(SP)0(LF)
```

avec la séquence origine à la fin et non pas au début du tableau.

Puis le programme tronque ces lignes à 9 caractères.


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

Ensuite, le programme filtre cette liste pour conserver uniquement les
chaînes commençant par un LF et se terminant de même.


```
(LF)bbbbb(SP)0(LF)
(LF)aaaaa(SP)1(LF)
```

Enfin, le programme extrait le tableau des codes de 5 caractères et le
tableau des notes.


```
bbbbb
aaaaa
---
0 1
```

Les propositions ne  sont pas dans l'ordre initial, mais  ce n'est pas
grave. L'essentiel est que cet ordre soit conservé dans le tableau des
notes.

On peut remarquer que si le  fichier comporte une seule ligne, elle ne
sera pas  extraite, car  même avec  la rotation,  elle ne  sera jamais
simultanément précédée  et suivie  par un  (LF). Mais  comment peut-on
avoir un problème avec un seul coup ?


#### `master∆nl` - Caractère NL (ou LF) et manque de portabilité

Je ne  sais pas comment  spécifier un caractère NL  ou LF dans  le cas
général. J'admets  que je  n'ai pas trop  regardé. En  revanche, c'est
facile avec  GNU-APL, il  suffit d'utiliser  un littéral  chaîne entre
double-quotes.  Mais  ce n'est  pas  portable.  J'isole ce  manque  de
portabilité dans une ligne de programme unique.


```
master∆nl ← "\n"
```

#### `master∆extract` - Extraction des données du problème

Le programme reçoit le chemin d'accès  du fichier et alimente les deux
variables  globales <tt>prop</tt>  et  <tt>notes</tt>.  Il ne  renvoie
aucune valeur.

Récupération du contenu du fichier


```
∇ master∆extract path; v; n; t; sel
v ← master∆slurp path
```

Génération du tableau «&nbsp;rotatif&nbsp;» et troncation à 9 colonnes


```
n ← ⍴ v
t ← ((⍳n) ⌽ (2⍴n) ⍴ v)[;⍳9]
```

Filtrons la liste pour conserver les  vecteurs avec un LF en positions
1 et 9 et un espace en position 7.


```
sel ← (master∆nl = t[;1]) ∧ (' ' = t[;7]) ∧ master∆nl = t[;9]
t ← t[sel/⍳n;]
```

Extrayons les  proposition et les  notes. Pour extraire les  notes, le
programme prend le chiffre et l'espace qui le précède. Si le programme
ne  prend pas  l'espace, cela  donne  une chaîne  avec uniquement  des
chiffres,  donc  l'opérateur  dequote  génère  un  nombre  à  <i>n</i>
chiffres. L'opérateur dequote est nécessaire  pour avoir un vecteur de
nombres au lieu d'un vecteur de caractères.


```
prop  ← t[;1 + ⍳5]
notes ← ⍎,t[;7 8]
∇
```

### Génération des différents codes possibles

#### `master∆letters` - Lettres utilisées pour la position <i>n</i>

Dans Master Mot, la lettre de la solution en colonne <i>n</i> apparaît
toujours  dans au  moins une  proposition dans  la même  colonne. Pour
extraire les lettres possibles pour  la colonne <i>n</i>, le programme
commence par extraire la colonne <i>n</i> en son entier.


```
∇ r ← master∆letters n; col
col ← prop[;n]
```

Mais il y a des doublons. Pour les éliminer, le programme commence par
trier les lettres.


```
col ← col[⍋col]
```

Ensuite, il teste  chaque caractère pour savoir s'il est  suivi par un
caractère identique. Si oui, il le supprime.

En fait, la logique est  inversée. Le programme teste chaque caractère
pour savoir s'il  est suivi par un caractère différent.  Si oui, il le
conserve.


```
r ← (col ≠ 1 ⌽ col) / col
∇
```

Remarque : si  la colonne <i>n</i> contient <var>x</var>  fois le même
caractère, la  fonction renvoie un  vecteur vide au lieu  d'un vecteur
avec un seul  caractère. Cela n'arrivera jamais dans  un vrai problème
de Master Mot. Nous pouvons faire l'impasse sur ce bug.


#### Génération des codes possibles de <var>n</var> caractères de long

La génération des  codes possibles de <var>n</var>  caractères se fait
en prenant  les codes possibles de  <var>n</var> - 1 caractères  et en
ajoutant un dernier caractère provenant de <tt><a href='#master∆letters' class='call'>master∆letters</a> n</tt>.

De  par  son  fonctionnement,  la  fonction  <tt><a href='#master∆letters' class='call'>master∆letters</a></tt>
renvoie un résultat trié. Donc les  codes possibles à 1 caractère sont
eux aussi triés.  Essayons de conserver cette propriété  pour la liste
des codes possibles à <var>n</var> caractères.

Supposons que la liste des codes possibles à 3 caractères soit


```
abc
def
ghi
```

et que la liste (triée) des lettres en colonne 4 soit


```
wxyz
```

Le résultat attendu est :


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

Cela se fait en indexant la liste des codes possibles à 3 lettres par


```
1 1 1 1 2 2 2 2 3 3 3 3
```

c'est-à-dire les  nombres 1 à  3 (car  3 possibilités) répétés  4 fois
(car 4 lettres dans la colonne  ajoutée) et en indexant les lettres de
la colonne 4 par


```
1 2 3 4 1 2 3 4 1 2 3 4
```

c'est-à-dire les nombres 1  à 4 (car 4 lettres) répétés  3 fois (car 3
possibilités dans la génération précédente).


#### `master∆generation`

Combien de codes possibles et combien de nouvelles lettres ?


```
∇ r ← poss master∆generation letters; np; nl; ip; il
np ← ¯1 ↓ ⍴ poss
nl ← ⍴ letters
```

Indices pour les codes possibles et pour les lettres


```
ip ← (np × nl) ⍴ ⍳ np
il ← (np × nl) ⍴ ⍳ nl
ip ← ip[⍋ip]
```

Concaténation des codes possibles de la génération précédente avec les
lettres


```
r ← poss[ip;] , letters[il]
∇
```

