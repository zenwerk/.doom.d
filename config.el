;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq doom-scratch-buffer-major-mode 'lisp-interaction-mode)

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
  ;; (dolist (mode '(eshell-mode))
  ;;   (add-to-list 'evil-emacs-state-modes mode))
  (evil-set-initial-state 'eshell-mode 'emacs)
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
        )
  ; fuzzy matching for company
  (company-flx-mode +1))

(def-package! beacon
  :custom
  (beacon-color "#009933")
  :hook (after-init . beacon-mode))

(def-package! jumplist
  :config
  (custom-set-variables
   '(jumplist-hook-commands
     '(find-file
       isearch-forward
       +lookup/definition
       end-of-buffer
       beginning-of-buffer))
   '(jumplist-ex-mode t)))

;; (def-package! iflipb
;;   :custom
;;   (iflipb-wrap-around t)
;;   (iflipb-ignore-buffers
;;    '("*Messages*"
;;      "Help*"
;;      "*doom*"
;;      "*new*"
;;      "*swiper*")))

(defun my-awesome-tab-hide-tab (x)
  (let ((name (format "%s" x)))
    (or
     ;; Current window is not dedicated window.
     (window-dedicated-p (selected-window))

     ;; Buffer name not match below blacklist.
     (string-prefix-p "*epc" name)
     (string-prefix-p "*helm" name)
     (string-prefix-p "*Compile-Log*" name)
     (string-prefix-p "*lsp" name)
     (string-prefix-p "*doom*" name)
     (string-prefix-p "*Messages*" name)

     ;; Is not magit buffer.
     (and (string-prefix-p "magit" name)
          (not (file-name-extension name)))
     )))

(def-package! awesome-tab
  :config
  (setq awesome-tab-hide-tab-function 'my-awesome-tab-hide-tab)
  (awesome-tab-mode t))

;; load windows settings
(defun wslp ()
  (and (eq system-type 'gnu/linux)
       (file-exists-p "/proc/sys/fs/binfmt_misc/WSLInterop")))
(when (or (eq system-type 'windows-nt)
          (wslp))
  (load! "+windows"))

;; load additional settings
(load! "+bindings")
