;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-
;; キーバインドの設定

(defun my-kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(map!
 :n "x" #'delete-char  ; 文字を削除するとき yank しない
 :i "C-h" "<DEL>"
 :g [M-f7] #'+lookup/references
 :nvig "C-s" #'swiper
 (:when (or IS-MAC (wslp))
   :map treemacs-mode-map "s-1" #'+treemacs/toggle)
 (:when (or IS-MAC (wslp))
   :nvig "s-`" #'+eshell/toggle
   :nvi "s-w" #'my-kill-current-buffer
   :nvi "s-1" #'+treemacs/toggle
   :nvi "s-v" #'yank-pop
   :nvi "s-b" #'+lookup/definition
   :nvi "s-/" #'evilnc-comment-or-uncomment-lines
   :nvi "s-o" #'imenu-anywhere))

;; ミニバッファで C-w で単語区切りで削除
(map! :map minibuffer-local-completion-map
      "C-w" #'backward-kill-word)

(defun my-eshell-key-map ()
  "Setup eshell keybindings. This must be done in a hook because eshell-mode
redefines its keys every time `eshell-mode' is enabled."
  (map! :map eshell-mode-map
        (:e "C-h" "<DEL>"
            "s-`" #'+eshell/toggle
            "C-p" #'eshell-previous-matching-input-from-input
            "C-n" #'eshell-next-matching-input-from-input
            "C-r" #'+eshell/search-history
            "TAB" #'+eshell/pcomplete
            [tab] #'+eshell/pcomplete
            "C-w C-w" #'other-window
            "C-w h" #'evil-window-left
            "C-w j" #'evil-window-down
            "C-w l" #'evil-window-right
            "C-w j" #'evil-window-up)
        (:when (or IS-MAC (wslp))
          :e "s-w" #'+eshell/kill-and-close)))
(add-hook 'eshell-first-time-mode-hook #'my-eshell-key-map)

(map!
 ;; (:after eshell-toggle
 ;;   (:nvig "s-`" #'eshell-toggle))
 ;; (:after iflibp
 ;;   (:nmvoig [C-tab] #'iflipb-next-buffer
 ;;            [C-S-tab] #'iflipb-previous-buffer))
 (:after jumplist
   (:g "C-<" #'jumplist-previous
       "C->" #'jumplist-next))
 (:after evil-nerd-commenter
   (:nvi "C-c /" #'evilnc-comment-or-uncomment-lines
         "C-c l" #'evilnc-quick-comment-or-uncomment-to-the-line
         "C-c c" #'evilnc-copy-and-comment-lines
         "C-c p" #'evilnc-comment-or-uncomment-paragraphs))
 (:after company
   (:map company-active-map
     "TAB" #'company-complete-selection
     [tab] #'company-complete-selection))
 (:after awesome-tab
   (:nvig [C-tab] #'awesome-tab-forward-tab
          [C-S-tab] #'awesome-tab-backward-tab
          [M-tab] #'awesome-tab-forward-group
          [M-S-tab] #'awesome-tab-backward-group
          [C-S-left] #'awesome-tab-move-current-tab-to-left
          [C-S-right] #'awesome-tab-move-current-tab-to-right)))
