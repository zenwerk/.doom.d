;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-
;; キーバインドの設定

(map!
 :n "x" #'delete-char  ; 文字を削除するとき yank しない
 :i "C-h" "<DEL>"
 :g "C-<" #'jumplist-previous
 :g "C->" #'jumplist-next
 (:when (or IS-MAC (wslp))
   :map treemacs-mode-map "s-1" #'+treemacs/toggle)
 (:when (or IS-MAC (wslp))
   :nvi "s-1" #'+treemacs/toggle
   :nvi "s-v" #'yank-pop
   :nvi "s-b" #'+lookup/definition
   :nvi "s-/" #'evilnc-comment-or-uncomment-lines
   :nvi "s-o" #'imenu-anywhere))

;; ミニバッファで C-w で単語区切りで削除
(map! :map minibuffer-local-completion-map
      "C-w" #'backward-kill-word)

;; iflipb でバッファの切り替え
(map! :nmvoig [C-tab] #'iflipb-next-buffer
      :nmvoig [C-S-tab] #'iflipb-previous-buffer)


(map!
 :nvi "C-c /" #'evilnc-comment-or-uncomment-lines
 :nvi "C-c l" #'evilnc-quick-comment-or-uncomment-to-the-line
 :nvi "C-c c" #'evilnc-copy-and-comment-lines
 :nvi "C-c p" #'evilnc-comment-or-uncomment-paragraphs)
