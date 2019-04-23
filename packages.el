;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! evil-nerd-commenter)

;; kaolin-themes を使う
;; (package! doom-themes :disable t)
(package! kaolin-themes :recipe (:fetcher github :repo "zenwerk/emacs-kaolin-themes"))
