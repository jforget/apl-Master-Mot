;;; config.el --- inserting APL chars into a buffer
; -*- encoding: utf-8; indent-tabs-mode: nil -*-

;;     Emacs configuration script to help write APL scripts and HTML sequences in hpweb files
;;     Copyright (C) 2015, 2016, 2025 Jean Forget
;;
;;     This program is distributed under the GNU Public License version 1 or later
;;
;;     You can find the text of the license in the F<LICENSE> file or at
;;     L<http://www.gnu.org/licenses/gpl-1.0.html>.
;;
;;     Here is the summary of GPL:
;;
;;     This program is free software; you can redistribute it and/or modify
;;     it under the terms of the GNU General Public License as published by
;;     the Free Software Foundation; either version 1, or (at your option)
;;     any later version.
;;
;;     This program is distributed in the hope that it will be useful,
;;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;     GNU General Public License for more details.
;;
;;     You should have received a copy of the GNU General Public License
;;     along with this program; if not, write to the Free Software Foundation,
;;     Inc., L<http://www.fsf.org/>.
;;
(progn
(find-file "master.hpweb")
(fundamental-mode)
(defun apl-insert ()
       "Inserting an APL char / insertion d'un caractère APL"
       (interactive)
                     ; arithmetic     vector             program
                     ; mathematic
  (let* ((apl-conv '(("times"  . "×") ("rho"      . "⍴") ("gets"    . "←")
                     ("div"    . "÷") ("iota"     . "⍳") ("goto"    . "→")
                     ("neg"    . "¯") ("drop"     . "↓") ("del"     . "∇")
                     ("circ"   . "○") ("take"     . "↑") ("lamp"    . "⍝")
                     ("floor"  . "⌊") ("slbar"    . "⌿") ("quad"    . "⎕")
                     ("ceil"   . "⌈") ("slbck"    . "⍀") ("qquad"   . "⍞")
                     ("log"    . "⍟") ("elem"     . "∈") ("enquote" . "⍕")
                     ("domino" . "⌹") ("jot"      . "∘") ("dequote" . "⍎")
                     ("encode" . "⊤") ("rotate"   . "⌽")
                     ("decode" . "⊥") ("transp"   . "⍉")
                     ("neq"    . "≠") ("carrot"   . "⍒")
                     ("leq"    . "≤") ("umbrella" . "⍋")
                     ("geq"    . "≥") ("each"     . "¨")
                     ("or"     . "∨") ("enclose"  . "⊂")
                     ("and"    . "∧") ("disclose" . "⊃")
                     ("delta"  . "∆")
                     ("elem"   . "∈")
                     ))
          (ch1 (cdr (assoc (completing-read "Car ? "
                                            (mapcar 'car apl-conv)
                                            nil t)
                            apl-conv))))
     (insert ch1))
)
(global-set-key '[f6] 'apl-insert)
(defun html-greater      () (interactive) (insert "&gt;"))
(defun html-lower        () (interactive) (insert "&lt;"))
(defun html-unbreak-spc  () (interactive) (insert "&nbsp;"))
(defun html-laquo        () (interactive) (insert "«&nbsp;"))
(defun html-raquo        () (interactive) (insert "&nbsp;»"))
(defun html-latex        () (interactive) (insert "L<sup>A</sup>T<sub>E</sub>X"))
(defun html-oelig        () (interactive) (insert "&oelig;"))
(defun html-list-item    () (interactive) (insert "
<li>

</li>
") (next-line -2) (end-of-line))

(defun html-tt () (interactive)
  (insert "<tt></tt>")
  (backward-char 5))

(defun html-langage (lang) (interactive "slangage? ")
  (insert "<i lang='" lang "'></i>")
  (backward-char 4))

(defun html-href-anchor (address) (interactive "sadress? ")
  (insert "<a href='" address "'></a>")
  (backward-char 4))

(defun add-shortcuts () (interactive)
  (define-key global-map "\C-c>"      'html-greater)
  (define-key global-map "\C-c<"      'html-lower)
  (define-key global-map "\C-c "      'html-unbreak-spc)
  (define-key global-map "\C-c\C-c>"  'html-raquo)
  (define-key global-map "\C-c\C-c<"  'html-laquo)
  (define-key global-map "\C-cl"      'html-latex)
  (define-key global-map "\C-co"      'html-oelig)
  (define-key global-map "\C-ct"      'html-tt)
  (define-key global-map "\C-ci"      'html-langage))
  (global-set-key '[f5] 'other-window)
(add-shortcuts)
(global-font-lock-mode -1)
)
