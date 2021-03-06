;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(add-hook 'doom-scratch-buffer-hook
          '(lambda () (lisp-interaction-mode)))

;; Highlight trailing whitespace
(setq-default show-trailing-whitespace t)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;; utf-8 を基本的に使用する
(prefer-coding-system 'utf-8)

;; 右端で折り返す
(setq-default truncate-lines nil)
(global-visual-line-mode t)


(def-package! base16-theme
  :config
  (load-theme 'base16-phd t))


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


(after! eshell
  (setq-default show-trailing-whitespace nil))


(after! company
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2
        ;; company-dabbrev-downcase nil
        ;; company-dabbrev-ignore-case t
        company-show-numbers nil)
                                        ; fuzzy matching for company
  (company-flx-mode 1))


(after! (:and treemacs all-the-icons)
  (setq treemacs-icons-hash (make-hash-table :size 200 :test #'equal)
        treemacs-icon-fallback (format "%s " (all-the-icons-faicon "file-text-o"))
        treemacs-icon-text treemacs-icon-fallback)

  ;; (setq treemacs-icon-open-png
  ;;       (concat
  ;;        (all-the-icons-octicon "chevron-down" :height 0.8 :v-adjust 0.1)
  ;;        "\t"
  ;;        (all-the-icons-octicon "file-directory" :v-adjust 0)
  ;;        "\t")
  ;;       treemacs-icon-closed-png
  ;;       (concat
  ;;        (all-the-icons-octicon "chevron-right" :height 0.8 :v-adjust 0.1 :face 'font-lock-doc-face)
  ;;        "\t"
  ;;        (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'font-lock-doc-face)
  ;;        "\

  (treemacs-create-theme "my-treemacs-theme"
    :config
    (progn
      (treemacs-create-icon :icon (format "%s " (all-the-icons-faicon "file-text-o")) :extensions (fallback))

      (treemacs-create-icon
       :icon (format " %s "(all-the-icons-octicon "repo"
                                                  :v-adjust -0.2
                                                  :height 1.4
                                                  :face 'font-lock-variable-name-face))
       :extensions (root))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-material "folder_open"
                                                   :v-adjust -0.2
                                                   :height 1.15
                                                   :face 'treemacs-directory-face))
       :extensions (dir-open))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-material "folder"
                                                   :v-adjust -0.2
                                                   :height 1.15
                                                   :face 'treemacs-directory-face))
       :extensions (dir-closed))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-faicon "chevron-down"
                                                 :v-adjust 0.1
                                                 :face 'font-lock-keyword-face))
       :extensions (tag-open))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-faicon "location-arrow"
                                                 :v-adjust 0.1
                                                 :face 'font-lock-keyword-face))
       :extensions (tag-closed))

      ;; ファイルタイプ
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".cs"))
       :extensions ("cs"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".css"))
       :extensions ("css"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".git"))
       :extensions ("gitconfig" "gitignore" "gitkeep" "gitmodules"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".html"))
       :extensions ("html" "htm"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".java"))
       :extensions ("java"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".js"))
       :extensions ("js"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".ts"))
       :extensions ("ts"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".py"))
       :extensions ("py"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".hs"))
       :extensions ("hs"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".c"))
       :extensions ("c" "h"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".cpp")) :extensions ("cpp" "cc" "hh" "hpp"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".rb"))
       :extensions ("rb"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".scala"))
       :extensions ("scala"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".ex"))
       :extensions ("ex"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".exs"))
       :extensions ("exs"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".erl"))
       :extensions ("erl"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".hrl"))
       :extensions ("hrl"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".clj"))
       :extensions ("clj"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".cljs"))
       :extensions ("cljs"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".el"))
       :extensions ("el"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".org"))
       :extensions ("org"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".jl"))
       :extensions ("jl"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".ml"))
       :extensions ("ml"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".mli"))
       :extensions ("mli"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".cl"))
       :extensions ("cl"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".php"))
       :extensions ("php"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".md"))
       :extensions ("md" "markdown"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".sh"))
       :extensions ("sh"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".zsh"))
       :extensions ("zsh"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".jsx"))
       :extensions ("jsx"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".vue"))
       :extensions ("vue"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-icon-for-file ".vim"))
       :extensions ("vim"))
      (treemacs-create-icon
       :icon (format "%s "  (all-the-icons-icon-for-file "Makefile"))
       :extensions ("Makefile" "Makefile.in"))
      (treemacs-create-icon
       :icon (format "%s "  (all-the-icons-icon-for-file "Dockerfile"))
       :extensions ("Dockerfile"))

      ;; icon with no colors
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "go"))
       :extensions ("go"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "cabal"))
       :extensions ("cabal"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "kotlin"))
       :extensions ("kt"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "hy"))
       :extensions ("hy"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "typescript"))
       :extensions ("ts"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "nimrod"))
       :extensions ("nim" "nims" "nimble"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "perl6"))
       :extensions ("pm6"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "tex"))
       :extensions ("tex"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-fileicon "rst"))
       :extensions ("rst"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-octicon "file-pdf"))
       :extensions ("pdf"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-octicon "database"))
       :extensions ("sql"))
      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-material "style"))
       :extensions ("styles"))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-octicon "file-media"))
       :extensions ("jpg" "jpeg" "png" "gif" "ico" "tif" "tiff" "svg" "bmp"
                    "psd" "ai" "eps" "indd" "mov" "avi" "mp4" "webm" "webp"
                    "mkv" "wav" "mp3" "ogg" "midi"))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-faicon "file-text-o"))
       :extensions ("log" "txt" "contribute" "license" "readme" "changelog"))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-faicon "cogs"))
       :extensions ("conf" "cfg" "yaml" "yml" "json" "xml" "toml" "cson" "ini"))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-octicon "code"))
       :extensions ("tpl" "erb" "mustache" "twig" "ejs" "mk" "haml" "pug" "jade"))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-faicon "code"))
       :extensions ("y" "l"))

      (treemacs-create-icon
       :icon (format "%s " (all-the-icons-alltheicon "script"))
       :extensions ("bat" "cgi"))
      ))
  (treemacs-load-theme "my-treemacs-theme")

  ;; (setq
  ;;  treemacs-icon-tag-node-open-png
  ;;  (format "%s " (all-the-icons-faicon "chevron-down"  :height 0.75 :face 'font-lock-keyword-face))

  ;;  treemacs-icon-tag-node-closed-png
  ;;  (format "%s " (all-the-icons-faicon "location-arrow" :height 0.9  :face 'font-lock-keyword-face))

  ;;  treemacs-icon-tag-leaf-png
  ;;  (format "%s " (all-the-icons-faicon "tag" :height 0.9 :face 'font-lock-type-face))
  ;;  )

  ;; Icons for filetypes with Color
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".cs")      "cs")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".css")      "css")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".git")      "gitignore"   "gitmodules"   "gitconfig"   "gitkeep")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".html")      "html"   "htm")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".java")      "java")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".js")      "js")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".ts")      "ts")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".py"      :face   'all-the-icons-green)   "py")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".py")      "pyc")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".rs")      "rs")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".hs")      "hs")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".c")      "c"   "h")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".cpp")      "cpp"   "C"   "cc"   "hpp")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".rb")      "rb")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".scala")   "scala")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".ex")      "ex")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".exs")      "exs")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".erl")      "hrl")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".hrl")      "hrl")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".clj")      "clj")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".cljs")      "cljs")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".el")      "el"   "elc")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".org")      "org")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".jl")      "jl")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".ml")      "ml")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".mli")      "mli")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".cl")      "lisp")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".php")      "php")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".md")      "md"   "markdown")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".sh")      "sh")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".zsh")      "zsh")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".jsx")      "jsx")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".vue")      "vue")
  ;; (treemacs-define-custom-icon   (all-the-icons-icon-for-file ".vim")      "vim"   "vimrc")
  ;; (treemacs-define-custom-icon (all-the-icons-icon-for-file "Makefile") "Makefile" "Makefile\.in")
  ;; (treemacs-define-custom-icon (all-the-icons-icon-for-file "Dockerfile") "Dockerfile")
  ;; ;; Icons with no color
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "go")            "go")
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "cabal")         "cabal")
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "kotlin")         "kt" "kts")
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "hy")            "hy")
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "typescript")    "ts")
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "nimrod")         "nim" "nims" "nimble")
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "perl6")         "pm6")
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "tex")            "tex")
  ;; (treemacs-define-custom-icon (all-the-icons-fileicon "rst")            "rst")
  ;; (treemacs-define-custom-icon (all-the-icons-octicon "file-pdf")        "pdf")
  ;; (treemacs-define-custom-icon (all-the-icons-octicon "database")         "sql")
  ;; (treemacs-define-custom-icon (all-the-icons-material "style")         "styles")

  ;; ;; メディアファイル
  ;; (treemacs-define-custom-icon (all-the-icons-octicon "file-media")
  ;;                              "jpg" "jpeg" "png" "gif" "ico" "tif" "tiff" "svg" "bmp"
  ;;                              "psd" "ai" "eps" "indd" "mov" "avi" "mp4" "webm" "mkv"
  ;;                              "wav" "mp3" "ogg" "midi")

  ;; ;; READMEなどのテキストファイル
  ;; (treemacs-define-custom-icon (all-the-icons-faicon "file-text-o")
  ;;                              "rst" "log" "txt" "CONTRIBUTE" "LICENSE" "README" "CHANGELOG")

  ;; ;; 設定ファイル系
  ;; (treemacs-define-custom-icon (all-the-icons-faicon "cogs")
  ;;                              "conf" "cfg" "yaml" "yml" "json" "xml" "toml" "cson" "ini")

  ;; ;; テンプレート関連
  ;; (treemacs-define-custom-icon (all-the-icons-octicon "code")
  ;;                              "tpl" "erb" "mustache" "twig" "ejs" "mk" "haml" "pug" "jade")

  ;; ;; 圧縮ファイル
  ;; (treemacs-define-custom-icon (all-the-icons-octicon "file-zip")
  ;;                              "zip" "xz" "tar" "7z" "rar" "gz")

  ;; ;; スクリプト実行ファイル
  ;; (treemacs-define-custom-icon (all-the-icons-alltheicon "script")
  ;;                              "bat" "cgi")

  ;; ;; 何らかのコード
  ;; (treemacs-define-custom-icon (all-the-icons-faicon "code")
  ;;                              "y" "l")

  ;; treemacs に表示しない条件
  (defun my-treemacs-ignore-func (filename absolute-path)
    (or (string-suffix-p ".pyc" filename)
        ;; (string-prefix-p "/x/y/z/" absolute-path))
        ))
  (add-to-list 'treemacs-ignored-file-predicates #'my-treemacs-ignore-func))

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
       ;; end-of-buffer
       ;; beginning-of-buffer
       +lookup/definition
       xref-find-definitions))
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

(defun my-awesome-tab-hide-tab (buf)
  (let ((name (format "%s" buf)))
    (or
     ;; Current window is not dedicated window.
     (window-dedicated-p (selected-window))

     ;; Buffer name not match below blacklist.
     (string-prefix-p "*epc" name)
     (string-prefix-p "*helm" name)
     (string-prefix-p "*Compile-Log*" name)
     (string-prefix-p "*lsp" name)
     (string-prefix-p "*doom*" name)
     (string-prefix-p "*doom:eshell" name)
     (string-prefix-p "*et:" name) ; for eshell-toggle
     ;; (string-prefix-p "*Messages*" name)

     ;; Buffer mode not match below blacklist.
     (with-current-buffer buf
       (or
        (derived-mode-p 'helpful-mode)))

     ;; Is not magit buffer.
     (and (string-prefix-p "magit" name)
          (not (file-name-extension name)))
     )))

(def-package! awesome-tab
  :config
  (setq awesome-tab-hide-tab-function 'my-awesome-tab-hide-tab)
  (awesome-tab-mode t))

(def-package! which-key-posframe
  :config
  (which-key-posframe-mode))

(def-package! eshell-toggle
  :custom
  ;; (eshell-toggle-window-side 'right)
  (eshell-toggle-init-function #'eshell-toggle-init-eshell)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-size-fraction 2))

;; load windows settings
(when (or (eq system-type 'windows-nt)
          (wslp))
  (load! "+windows"))

;; load additional settings
(load! "+bindings")
