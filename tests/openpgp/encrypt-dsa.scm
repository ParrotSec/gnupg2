#!/usr/bin/env gpgscm

;; Copyright (C) 2016 g10 Code GmbH
;;
;; This file is part of GnuPG.
;;
;; GnuPG is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
;; (at your option) any later version.
;;
;; GnuPG is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, see <http://www.gnu.org/licenses/>.

(load (in-srcdir "tests" "openpgp" "defs.scm"))
(setup-legacy-environment)

(for-each-p
 "Checking encryption using DSA"
 (lambda (source)
   (tr:do
    (tr:open source)
    (tr:gpg "" `(--yes --encrypt --recipient ,dsa-usrname2))
    (tr:gpg "" '(--yes --decrypt))
    (tr:assert-identity source)))
 (append plain-files data-files))

(for-each-p
 "Checking encryption using DSA and a specific cipher algorithm"
 (lambda (cipher)
   (for-each-p
    ""
    (lambda (source)
      (tr:do
       (tr:open source)
       (tr:gpg "" `(--yes --encrypt --recipient ,dsa-usrname2
			  --cipher-algo ,cipher))
       (tr:gpg "" '(--yes --decrypt))
       (tr:assert-identity source)))
    (append plain-files data-files)))
 (force all-cipher-algos))
