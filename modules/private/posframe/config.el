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
  (ivy-posframe-border-width 7)
  :custom-face
  (ivy-posframe ((t (:background "#282a36"))))
  ;; (ivy-posframe-border ((t (:background "#6272a4"))))
  ;; (ivy-posframe-cursor ((t (:background "#61bfff"))))
  :config
  (setq ivy-display-function #'ivy-posframe-display-at-frame-center)
  (ivy-posframe-enable)
  )

(def-package! hydra-posframe
  :config
  (hydra-posframe-enable))

(def-package! flymake-posframe
  :hook (flymake-mode . flymake-posframe-mode))
