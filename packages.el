;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(disable-packages! anaconda-mode company-irony company-irony-c-headers flycheck-irony irony irony-eldoc ivy-rtags rtags)

(package! evil-nerd-commenter)

(package! beacon)

(package! jumplist)

(package! company-flx)

;; kaolin-themes を使う
;; (package! doom-themes :disable t)
(package! kaolin-themes :recipe (:fetcher github :repo "zenwerk/emacs-kaolin-themes" :files ("*" "themes/*")))
