;;; private/ivy/config.el -*- lexical-binding: t; -*-

(def-package! counsel
  :diminish ivy-mode
   :config
   (map!
    :g "C-S-a" #'counsel-M-x
    :g "C-S-o" #'counsel-find-file))

(def-package! ivy-posframe
  :custom
  (ivy-posframe-parameters
   '((left-fringe . 5)
     (right-fringe . 5)))
  (ivy-posframe-border-width 2) ; mac では反映されない
  (ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  :custom-face
  (ivy-posframe ((t (:background "#282a36"))))
  (ivy-posframe-border ((t (:background "#6272a4")))) ; mac では反映されない
  (ivy-posframe-cursor ((t (:background "#61bfff")))) ; mac では反映されない
  :config
  (ivy-posframe-enable))

(def-package! hydra-posframe
  :config
  (hydra-posframe-enable))

(def-package! flymake-posframe
  :hook (flymake-mode . flymake-posframe-mode))
