;;; ~/.doom.d/+windows.el -*- lexical-binding: t; -*-

;; 色味調整
(setq doom-one-brighter-comments t) ; コメントの文字色を明るくする
(setq doom-one-comment-bg nil) ; コメント行の背景色を明るくしない

;; Win キーを Super モディファイアキーに
(setq w32-pass-lwindow-to-system nil
      w32-pass-rwindow-to-system nil
      w32-pass-apps-to-system nil
      w32-lwindow-modifier 'super
      w32-rwindow-modifier 'super
      w32-apps-modifier 'hyper)

;; For Windows encoding
(define-coding-system-alias 'cp65001 'utf-8)

;; NTEmacs26.1 64bit 日本語IME向けパッチ設定
(when (locate-library "w32-ime")
  (require 'w32-ime)
  (progn
    ;; Windows IME
    (setq default-input-method "W32-IME")
    (setq-default w32-ime-mode-line-state-indicator "[--]")
    (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
    (w32-ime-initialize)
    ;; 日本語入力時にカーソルの色を変える設定
    (add-hook 'w32-ime-on-hook '(lambda () (set-cursor-color "coral4")))
    (add-hook 'w32-ime-off-hook '(lambda () (set-cursor-color "black")))

    ;; ミニバッファに移動した際は最初に日本語入力が無効な状態にする
    (add-hook 'minibuffer-setup-hook 'deactivate-input-method)

    ;; isearch に移行した際に日本語入力を無効にする
    (add-hook 'isearch-mode-hook '(lambda ()
                                    (deactivate-input-method)
                                    (setq w32-ime-composition-window (minibuffer-window))))
    (add-hook 'isearch-mode-end-hook '(lambda () (setq w32-ime-composition-window nil)))

    ;; ivy 使用中に日本語入力を無効にする
    (advice-add 'ivy :around '(lambda (orig-fun &rest args)
                                 (let ((select-window-functions nil)
                                       (w32-ime-composition-window (minibuffer-window)))
                                   (deactivate-input-method)
                                   (apply orig-fun args))))
    ))
(message "loaded Windows specific configulation.")
