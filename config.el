;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(when (eq system-type 'windows-nt)
  (define-coding-system-alias 'cp65001 'utf-8))


;; キーバインドの設定
(map!
 (:when IS-MAC
   "s-1" #'treemacs))



;; モジュールの設定
;(after! モジュール名)
