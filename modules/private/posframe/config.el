;;; private/ivy/config.el -*- lexical-binding: t; -*-

(def-package! counsel
  :diminish ivy-mode
   :config
   (map!
    :g "C-S-a" #'counsel-M-x
    :g "C-S-o" #'counsel-find-file))

(def-package! ivy-posframe
  :config
  (setq ivy-display-function #'ivy-posframe-display-at-frame-center)
  (ivy-posframe-enable))

(def-package! hydra-posframe
  :hook (after-init . hydra-posframe-enable))

(def-package! flymake-posframe
  :hook (flymake-mode . flymake-posframe-mode))
