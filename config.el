;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Highlight trailing whitespace
(setq-default show-trailing-whitespace t)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;; utf-8 を基本的に使用する
(prefer-coding-system 'utf-8)

;; 右端で折り返す
(setq-default truncate-lines nil)
(global-visual-line-mode t)

;; my fork of koalin-themes
(def-package! kaolin-themes
  :config
  (load-theme 'kaolin-ocean t)
  (kaolin-treemacs-theme))

;; モジュールの設定
(after! evil
  ;; Modes that don't use evil
  (setq evil-emacs-state-modes (append evil-emacs-state-modes
                                       '(eshell-mode)))
  ;; j,k で物理行移動, gj,gk で論理行移動
  (defun evil-swap-key (map key1 key2)
    "MAP中のKEY1とKEY2を入れ替え"
    (let ((def1 (lookup-key map key1))
          (def2 (lookup-key map key2)))
      (define-key map key1 def2)
      (define-key map key2 def1)))
  (evil-swap-key evil-motion-state-map "j" "gj")
  (evil-swap-key evil-motion-state-map "k" "gk"))

(after! company
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2
        company-show-numbers nil
        ;; company-dabbrev-downcase nil
        ;; company-dabbrev-ignore-case t
        ))

;; load windows settings
(defun wslp ()
  (and (eq system-type 'gnu/linux)
       (file-exists-p "/proc/sys/fs/binfmt_misc/WSLInterop")))
(when (or (eq system-type 'windows-nt)
          (wslp))
  (load! "+windows"))

;; load additional settings
(load! "+bindings")
