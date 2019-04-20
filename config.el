;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(when (eq system-type 'windows-nt)
  (define-coding-system-alias 'cp65001 'utf-8))

(setq doom-one-brighter-comments t)

;; Highlight trailing whitespace
(setq-default show-trailing-whitespace t)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;; utf-8 を基本的に使用する
(prefer-coding-system 'utf-8)

;; 右端で折り返す
(setq-default truncate-lines nil)

;; キーバインドの設定
(map!
 :n "x" #'delete-char  ; 文字を削除するとき yank しない
 :i "C-h" "<DEL>"
 (:when IS-MAC
   :nvi "s-1" #'treemacs
   :nvi "s-v" #'clipboard-yank))

;; ミニバッファで C-w で単語区切りで削除
(map! :map :minibuffer-local-completion-map
      "C-w" #'backward-kill-word)

;; モジュールの設定
;(after! モジュール名)
