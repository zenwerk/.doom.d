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


;; for LinuxBrew
(when (wslp)
  (let ((home (getenv "HOME")))
    (add-to-list 'exec-path (concat home "/bin")))
  (let ((home "/home/linuxbrew"))
    (add-to-list 'exec-path (concat home "/.linuxbrew/bin"))
    (add-to-list 'exec-path (concat home "/.linuxbrew/sbin")))
  (setenv "PATH" (string-join exec-path ":"))
  (message "Update exec-path and PATH at init.el for WSL"))

;; for Mozc-ime
(when (wslp)
  (require 'mozc-im)
  (require 'mozc-popup)
  (require 'mozc-cursor-color)
  (require 'wdired)

  (setq default-input-method "japanese-mozc-im")

  ;; popupスタイル を使用する
  (setq mozc-candidate-style 'popup)

  ;; カーソルカラーを設定する
  (setq mozc-cursor-color-alist '((direct        . "red")
                                  (read-only     . "yellow")
                                  (hiragana      . "green")
                                  (full-katakana . "goldenrod")
                                  (half-ascii    . "dark orchid")
                                  (full-ascii    . "orchid")
                                  (half-katakana . "dark goldenrod")))

  ;; カーソルの点滅を OFF にする
  (blink-cursor-mode 0)

  ;; S-<SPC> で IME をトグルする
  (global-set-key (kbd "S-<SPC>") 'toggle-input-method)
  (define-key isearch-mode-map (kbd "S-<SPC>") 'isearch-toggle-input-method)
  (define-key wdired-mode-map (kbd "S-<SPC>") 'toggle-input-method)

  ;; mozc-cursor-color を利用するための対策
  ;; (defvar mozc-im-mode nil)
  ;; (make-variable-buffer-local 'mozc-im-mode)
  (defvar-local mozc-im-mode nil)
  (add-hook 'mozc-im-activate-hook (lambda () (setq mozc-im-mode t)))
  (add-hook 'mozc-im-deactivate-hook (lambda () (setq mozc-im-mode nil)))
  (advice-add 'mozc-cursor-color-update
              :around (lambda (orig-fun &rest args)
                        (let ((mozc-mode mozc-im-mode))
                          (apply orig-fun args))))

  ;; isearch を利用する前後で IME の状態を維持するための対策
  (add-hook 'isearch-mode-hook (lambda () (setq im-state mozc-im-mode)))
  (add-hook 'isearch-mode-end-hook
            (lambda ()
              (unless (eq im-state mozc-im-mode)
                (if im-state
                    (activate-input-method default-input-method)
                  (deactivate-input-method)))))

  ;; wdired 終了時に IME を OFF にする
  (advice-add 'wdired-finish-edit
              :after (lambda (&rest args)
                       (deactivate-input-method)))
  ;; Windows の mozc では、セッション接続直後 directモード になるので hiraganaモード にする
  (advice-add 'mozc-session-execute-command
            :after (lambda (&rest args)
                     (when (eq (nth 0 args) 'CreateSession)
                       ;; (mozc-session-sendkey '(hiragana)))))
                       (mozc-session-sendkey '(Hankaku/Zenkaku)))))

  (setq mozc-helper-program-name "mozc_emacs_helper.sh"))


(message "loaded Windows specific configulation.")
