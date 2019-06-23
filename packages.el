;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(disable-packages! anaconda-mode company-irony company-irony-c-headers flycheck-irony irony irony-eldoc ivy-rtags rtags)

(package! evil-nerd-commenter)

(package! company-flx)

(package! which-key-posframe)

;; buffer move
;; (package! iflipb :recipe (:fetcher github :repo "jrosdahl/iflipb"))
(package! awesome-tab :recipe (:fetcher github :repo "manateelazycat/awesome-tab"))
(package! beacon)
(package! jumplist)

;; external themes
;; (package! doom-themes :disable t)
(package! kaolin-themes)
(package! base16-theme)
