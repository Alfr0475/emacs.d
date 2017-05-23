;;------------------------------------------------------------------------------
;; init.el が読み込まれた後に実行される hook

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-hook 'after-init-hook
          (lambda ()
            (ec-load-el-get-config)
            (ec-load-load-path-config)
            (ec-load-system-config)
            (ec-load-whitespace-config)
            (ec-load-tabbar-config)
            (ec-load-company-config)
            ;;(ec-load-flycheck-config)
            ))

;;------------------------------------------------------------------------------
;; Emacs起動時に実行される hook
;; after-init-hook よりも後に実行される
(add-hook 'emacs-startup-hook
          (lambda ()
            (ec-load-string-code-config)
            (ec-load-mode-line-config)
            (ec-load-scroll-config)
            (ec-load-window-config)
            (ec-load-ime-config)
            (ec-load-undo-tree)
            (ec-load-recentf-config)
            (ec-load-session-config)
            (ec-load-grep-config)
            (ec-load-which-key-config)
            (ec-load-migemo-config)
            (ec-load-popwin-config)
            (ec-load-dired-config)
            (ec-load-font-config)
            (ec-load-helm-config)
            (ec-load-coding-config)
            ;; (ec-load-auto-complete-config)
            (ec-load-diff-config)
            (ec-load-anzu-config)
            (ec-load-auto-highlight-symbol-config)
            ;; (ec-load-git-gutter-fringe-config)
            (ec-load-rainbow-mode-config)
            (ec-load-rainbow-delimiters-config)
            (ec-load-align-config)
            (ec-load-pcre2el-config)
            (ec-load-original-c-style-config)
            (ec-load-php-mode-config)
            (ec-load-web-mode-config)
            (ec-load-sh-mode-config)
            (ec-load-cmd-mode-config)
            (ec-load-markdown-mode-config)
            (ec-load-textile-mode-config)
            (ec-load-yaml-mode-config)
            (ec-load-json-mode-config)
            (ec-load-csv-mode-config)
            (ec-load-tsv-mode-config)
            (ec-load-css-mode-config)
            (ec-load-scss-mode-config)
            (ec-load-sass-mode-config)
            (ec-load-org-mode-config)
            (ec-load-auto-insert-config)
            (ec-load-navi2ch-config)
            (ec-load-open-junk-file-config)
            (ec-load-magit-config)
            (ec-load-google-translate-config)
            (ec-load-themes-config)
            (ec-load-keybind-config)

            (ec-load-server-config)
            ))


(defun ec-load-el-get-config ()
  "El-get configuration."
  (when load-file-name
    (setq user-emacs-directory (file-name-directory load-file-name)))

  ;; OSによってインストール先を変える
  ;; http://d.hatena.ne.jp/tarao/20150221/1424518030#tips-package-directory
  (let ((run-os-dir (locate-user-emacs-file (format "packages/%s-%s" run-os-name run-window-system-name))))
    (setq el-get-dir (expand-file-name "el-get" run-os-dir)
          package-user-dir (expand-file-name "elpa" run-os-dir))

    (setq load-path
          (append
           (list
            (expand-file-name (concat user-emacs-directory  "packages"))
            (expand-file-name (concat run-os-dir "/el-get/el-get"))
            (expand-file-name run-os-dir)
            )
           load-path)))


  ;; El-Getがインストールされていなければダウンロードしてインストール
  ;; http://d.hatena.ne.jp/tarao/20150221/1424518030#el-get-setup
  (unless (require 'el-get nil 'noerror)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
      (goto-char (point-max))
      (eval-print-last-sexp)))

  ;; El-Get install packages
  (when (load (format "install-packages-%s-%s" run-os-name run-window-system-name) nil t))
  )


;;------------------------------------------------------------------------------
;; load-path
(defun ec-load-load-path-config ()
  "Load Path configuration."
  (setq load-path
        (append
         (list
          (expand-file-name (concat user-emacs-directory "data/c-style"))
          )
         load-path))
  )

;;------------------------------------------------------------------------------
;; 基本的な設定
(defun ec-load-system-config ()
  "System configuration."
  (cd "~/")                               ; デフォルトディレクトリ
  (set-language-environment "Japanese")   ; 言語設定

  (tool-bar-mode -1)                      ; ツールバー非表示
  (setq resize-mini-windows nil)          ; ミニバッファのサイズを変更不可
  (setq inhibit-startup-message t)        ; 起動時の画面非表示
  (setq transient-mark-mode t)            ; リージョンに色をつける
  (global-hl-line-mode 1)                 ; カレント行に色をつける
  (setq highlight-nonselected-windows t)  ; バッファを切り替えてもリージョンの色が残る
  (delete-selection-mode 1)               ; リージョン選択中に文字入力でリージョン内の文字を消す
  (setq backup-inhibited t)               ; バックアップファイルを作らない
  (setq delete-auto-save-files t)         ; 終了時にオートセーブファイルを消す
  (setq ring-bell-function 'ignore)       ; bell消音
  (defalias 'yes-or-no-p 'y-or-n-p)       ; Yes or No の選択肢を省略化
  (setq completion-ignore-case t)         ; 補完の大文字小文字無視
  (global-auto-revert-mode 1)             ; バッファ自動再読み込み
  (setq delete-by-moving-to-trash t)      ; ファイル削除でごみ箱へ
  (line-number-mode t)                    ; カーソル行表示
  (column-number-mode t)                  ; カーソル列表示
  (blink-cursor-mode 0)                   ; カーソル点滅表示
  (exec-path-from-shell-initialize)       ; Shellのパスを引き継ぐ

  ;; C-x C-C で終了するキーバインドを無効にしたのでEmacsを終了するaliase追加
  (defalias 'exit-emacs 'save-buffers-kill-emacs)

  ;; suspend-emacs を無効化
  (bind-key "C-z" nil)

  (setq auto-save-list-file-prefix "~/.emacs.d/tmp/auto-save-list/.saves-")
  (setq tramp-persistency-file-name "~/.emacs.d/tmp/tramp")
  (setq smex-save-file "~/.emacs.d/tmp/smex-items")
  (setq url-cookie-file "~/.emacs.d/tmp/url/cookies")
  (setq url-configuration-directory "~/.emacs.d/tmp/url/")
  (setq pcache-directory "~/.emacs.d/tmp/pcache/")
  (setq nsm-settings-file "~/.emacs.d/tmp/network-security.data")
  )

;;------------------------------------------------------------------------------
;; 文字コード
(defun ec-load-string-code-config ()
  "StringCode configuration."
  (prefer-coding-system 'utf-8-unix)      ; デフォルトの文字コード
  (set-default-coding-systems 'utf-8)     ; デフォルトの文字コード
  (set-keyboard-coding-system 'utf-8)     ; キーボード
  (set-terminal-coding-system 'utf-8)     ; ターミナル

  (use-package ucs-normalize
    :config
    (set-file-name-coding-system 'utf-8-hfs)) ; ファイル名(Mac日本語の濁音/半濁音対応)

  (set-default 'buffer-file-coding-system 'utf-8-unix) ; バッファー
  )

;;------------------------------------------------------------------------------
;; モードライン
(defun ec-load-mode-line-config ()
  "Mode line configuration."
  ;; 改行コード表示
  (setq eol-mnemonic-dos "(CRLF)")
  (setq eol-mnemonic-mac "(CR)")
  (setq eol-mnemonic-unix "(LF)")

  ;; 表示時刻のカスタマイズ
  (setq display-time-string-forms
        '(year "/" month "/" day " " dayname " " 24-hours ":" minutes))
  (display-time)                        ; 時刻表示
  )

;;------------------------------------------------------------------------------
;; スクロール
(defun ec-load-scroll-config ()
  "Scroll configuration."
  (setq next-screen-context-lines 2)       ; 画面スクロール時の重複行数
  (setq scroll-margin 5)                   ; 画面端に到達する前に画面がスクロールする
  (setq scroll-preserve-screen-position t) ; スクロール時になるべくカーソル位置を変えない
  )

;;------------------------------------------------------------------------------
;; ウィンドウ
(defun ec-load-window-config ()
  "Window configuration."
  (progn
    (set-scroll-bar-mode nil)         ; スクロールバー非表示
    (setq ns-pop-up-frames nil)       ; 複数起動防止
    (define-key global-map [ns-drag-file] 'ns-find-file)) ; D&Dの挙動をファイルを開く操作に変更

  (setq initial-frame-alist
        (append (list
                 '(width . 190)
                 '(height . 50)
                 )
                initial-frame-alist))
  (setq default-frame-alist initial-frame-alist)

  ;; 同名ファイル等はディレクトリパスもつける
  (use-package uniquify
    :config
    (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
    (setq uniquify-ignore-buffers-re "*[^*]+*")) ; *scratch*等を省く

  (use-package hlinum
    :init
    (global-linum-mode t)                   ; バッファ中の行番号表示
    :config
    (setq linum-format "%5d"))               ; 行番号書式
  )

;;------------------------------------------------------------------------------
;; IME
(defun ec-load-ime-config ()
  "IME configuration."
  (setq default-input-method "MacOSX")
  (mac-add-key-passed-to-system 'shift)
  (add-hook 'after-init-hook 'mac-change-language-to-us) ; 起動したら英字にする
  (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us) ;ミニバッファを開いた時に英字にする

  (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "あ")

  (mac-translate-from-yen-to-backslash)   ; backslashを優先
  )

;;------------------------------------------------------------------------------
;; undo-tree
(defun ec-load-undo-tree ()
  "Undo-tree configuration."
  (use-package undo-tree
    :diminish undo-tree-mode
    :init
    (global-undo-tree-mode t)
    :config
    (custom-set-variables
     '(undo-tree-auto-save-history t)
     '(undo-tree-history-directory-alist '(("". "~/.emacs.d/tmp/undo-tree")))
     '(undo-tree-visualizer-timestamps t)
     )
    (bind-key "C-g" 'undo-tree-visualizer-quit undo-tree-visualizer-mode-map)
    (bind-key "RET" 'undo-tree-visualizer-quit undo-tree-visualizer-mode-map)
    :bind
    (("M-/" . undo-tree-redo)))
  )

;;------------------------------------------------------------------------------
;; recentf
(defun ec-load-recentf-config ()
  (use-package recentf
    :config
    (setq recentf-max-saved-items 2000)   ; 最近開いたファイル
    (custom-set-variables '(recentf-save-file "~/.emacs.d/tmp/recentf"))
    (setq recentf-exclude '("~/.emacs.d/tmp/recentf"))
    (setq recentf-auto-cleanup 10)
    (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
    (use-package recentf-ext))
  )

;;------------------------------------------------------------------------------
;; session
(defun ec-load-session-config ()
  ;; ミニバッファ履歴リストの最大長：tなら無限
  (setq history-length t)

  ;; session.el
  ;;   kill-ringやミニバッファで過去に開いたファイルなどの履歴を保存する
  (use-package session
    :config
    (setq session-initialize '(de-saveplace session keys menus places)
          session-globals-include '((kill-ring 50)
                                    (session-file-alist 500 t)
                                    (file-name-history 10000)))
    (add-hook 'after-init-hook 'session-initialize)
    (setq session-save-file "~/.emacs.d/tmp/session")

    ;; 前回閉じたときの位置にカーソルを復帰
    (setq session-undo-check -1))

  ;; minibuf-isearch
  ;;   minibufでisearchを使えるようにしてsessionの履歴を検索しやすくする
  ;;(use-package minibuf-isearch)
  )

;;------------------------------------------------------------------------------
;; grep
(defun ec-load-grep-config ()
  (use-package grep
    :config
    ;; grepをUTF-8に
    (defadvice grep (around grep-coding-setup activate)
      (let ((coding-system-for-read 'utf-8))
        ad-do-it))

    ;; grep結果を編集して反映させる
    (use-package wgrep
      :config
      (setq wgrep-change-readonly-file t)
      (setq wgrep-enable-key "e")))
  )

;;------------------------------------------------------------------------------
;; which-key
(defun ec-load-which-key-config ()
  (use-package which-key
    :diminish which-key-mode
    :init
    (which-key-mode 1)
    :config
    ;; 3つの表示方法どれか1つ選ぶ
    (which-key-setup-side-window-bottom)       ; ミニバッファ
    ;; (which-key-setup-side-window-right)        ; 右端
    ;; (which-key-setup-side-window-right-bottom) ; 両方使う
    )
  )

;;------------------------------------------------------------------------------
;; migemo
(defun ec-load-migemo-config ()
  (when
      (and
       (executable-find "cmigemo")
       (require 'migemo nil t))

    (cond ((and run-darwin)
           (setq migemo-command "/usr/local/bin/cmigemo") ; cmigemoを使う
           (setq migemo-options '("-q" "--emacs")) ; コマンドラインオプション
           (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict") ; migemo辞書の場所
           )
          (t
           (setq migemo-command "cmigemo")    ; cmigemoを使う
           (setq migemo-options '("-q" "-e")) ; コマンドラインオプション
           (setq migemo-dictionary "~/.emacs.d/data/migemo/utf-8/migemo-dict") ; migemo辞書の場所
           ))

    (setq migemo-user-dictionary nil) ; cmigemoで必須設定。おそらくuser単位の辞書の場所
    (setq migemo-regex-dictionary nil) ; cmigemoで必須設定。おそらく正規表現辞書かな？
    (setq migemo-coding-system 'utf-8-unix) ; cmigemoの文字コード設定

    (migemo-init)
    )
  )

;;------------------------------------------------------------------------------
;; popwin
(defun ec-load-popwin-config ()
  (use-package popwin
    :config
    (setq display-buffer-function 'popwin:display-buffer)

    (setq popwin:popup-window-position 'bottom) ; ポップアップの位置を画面下に表示
    (setq helm-samewindow nil)                  ; helmのポップアップウィンドウ対応

    ;; ポップアップバッファ一覧
    (setq popwin:special-display-config '(
                                          (" *auto-async-byte-compile*" :height 14 :noselect t)
                                          ("helm" :regexp t :height 0.4)
                                          ("*Google Translate*" :noselect t)
                                          ("*Warnings*" :noselect t)
                                          ("*Compile-Log*" :noselect t)
                                          ("*compilation*" :noselect t)
                                          ("*magit-process*" :noselect t)
                                          ("*magit-diff*" :height 0.4)
                                          ("*Kill Ring*" :height 0.4)
                                          ("*grep*" :height 0.4)
                                          ("*Help*" :noselect t)
                                          ("*Omnisharp Symbols*" :noselect t)
                                          )))
  )

;;------------------------------------------------------------------------------
;; dired
(defun ec-load-dired-config ()
  ;; dired拡張
  (load "dired-x")

  ;; find-diredをLinux環境無しで使えるように
  (autoload 'find-dired-lisp
    "find-dired-lisp" "findr" t nil)
  (autoload 'find-grep-dired-lisp
    "find-dired-lisp" "findr" t nil)


  ;; スペースでマークする (FD like)
  (define-key dired-mode-map " " 'dired-toggle-mark)
  (defun dired-toggle-mark (arg)
    "Toggle the current (or next ARG) files."
    ;; S.Namba Sat Aug 10 12:20:36 1996
    (interactive "P")
    (let ((dired-marker-char
           (if (save-excursion (beginning-of-line)
                               (looking-at " "))
               dired-marker-char ?\040)))
      (dired-mark arg)
      (dired-previous-line 1)))

  (put 'dired-find-alternate-file 'disabled nil)
  (add-hook 'dired-mode-hook
            '(lambda ()
               (make-local-variable 'mouse-highlight)
               (setq mouse-highlight nil)
               (local-set-key (kbd "RET") 'dired-find-alternate-file)
               (local-set-key (kbd "C-<return>") 'dired-advertised-find-file)
               ))

  ;; dired を使って、一気にファイルの coding system (漢字) を変換する
  ;; マークを付けたファイルに対してTで変換
  ;; ついでにディレクトリを選ぶ度にバッファが作られるのを抑制。
  ;; さらにマウスカーソルがあたってハイライトしないように設定。
  (require 'dired-aux)
  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key (current-local-map) "T" 'dired-do-convert-coding-system)
              (make-local-variable 'mouse-highlight)
              (setq mouse-highlight nil)
              (local-set-key (kbd "RET") 'dired-find-alternate-file)
              (local-set-key (kbd "C-<return>") 'dired-advertised-find-file)
              ))

  (defvar dired-default-file-coding-system nil
    "*Default coding system for converting file (s).")

  (defvar dired-file-coding-system 'no-conversion)

  (defun dired-convert-coding-system ()
    (let ((file (dired-get-filename))
          (coding-system-for-write dired-file-coding-system)
          failure)
      (condition-case err
          (with-temp-buffer
            (insert-file file)
            (write-region (point-min) (point-max) file))
        (error (setq failure err)))
      (if (not failure)
          nil
        (dired-log "convert coding system error for %s:\n%s\n" file failure)
        (dired-make-relative file))))

  (defun dired-do-convert-coding-system (coding-system &optional arg)
    "Convert file (s) in specified coding system."
    (interactive
     (list (let ((default (or dired-default-file-coding-system
                              buffer-file-coding-system)))
             (read-coding-system
              (format "Coding system for converting file (s) (default, %s): "
                      default)
              default))
           current-prefix-arg))
    (check-coding-system coding-system)
    (setq dired-file-coding-system coding-system)
    (dired-map-over-marks-check
     (function dired-convert-coding-system) arg 'convert-coding-system t))


  ;; コピー、削除を再帰的にできるように
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)


  ;; 今日変更したファイルの時間に色を付ける
  (defface dired-todays-face '((t (:foreground "green"))) nil)
  (defvar dired-todays-face 'dired-todays-face)

  (defconst month-name-alist
    '(("1"  . "Jan") ("2"  . "Feb") ("3"  . "Mar") ("4"  . "Apr")
      ("5"  . "May") ("6"  . "Jun") ("7"  . "Jul") ("8"  . "Aug")
      ("9"  . "Sep") ("10" . "Oct") ("11" . "Nov") ("12" . "Dec")))

  (defun dired-today-search (arg)
    "Fontlock search function for dired."
    (search-forward-regexp
     (let ((month-name
            (cdr (assoc (format-time-string "%b") month-name-alist))))
       (if month-name
           (format
            (format-time-string
             "\\(%Y-%m-%d\\|%b %e\\|%%s %e\\) [0-9]....") month-name)
         (format-time-string
          "\\(%Y-%m-%d\\|%b %e\\) [0-9]....")))
     arg t))

  (eval-after-load "dired"
    '(font-lock-add-keywords
      'dired-mode
      (list '(dired-today-search . dired-todays-face))))


  ;; sorter改良版
  (add-hook 'dired-load-hook
            (lambda ()
              (require 'sorter)))

  (require 'ls-lisp)
  (setq ls-lisp-dirs-first t)                ; ディレクトリを先に表示
  (setq ls-lisp-use-localized-time-format t) ; 指定した日付フォーマットを使う
  (setq ls-lisp-format-time-list (quote ("%Y-%m-%d %H:%M" "%Y-%m-%d %H:%M"))) ; dired上の時間フォーマット

  (require 'wdired)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
  )

;;------------------------------------------------------------------------------
;; フォント
(defun ec-load-font-config ()
  ;;------------------------------------------------------------------------------
  ;; フォント設定確認用
  ;;------------------------------------------------------------------------------
  ;; abcdeABCDE
  ;; ａｂｃｄｅＡＢＣＤＥ
  ;; あいうえお
  ;; アイウエオ
  ;; +*!?\
  ;; ＋＊！？￥
  ;; ー～・％＆
  ;; ①②③④⑤⑥⑦⑧⑨⑩
  ;; ㍉㌢㌔㍍
  ;; ✕÷±＋
  ;; ◎○●△▲□■◇◆
  ;;------------------------------------------------------------------------------
  (set-face-attribute 'default nil
                      :family "Ricty for Powerline"
                      :height 140)
  (set-fontset-font "fontset-default"
                    'japanese-jisx0208
                    '("Ricty for Powerline")) ; 全角文字
  (set-fontset-font "fontset-default"
                    'katakana-jisx0201
                    '("Ricty for Powerline")) ; 半角カタカナ
  (set-fontset-font "fontset-default"
                    'cp932
                    '("Ricty for Powerline")) ; 機種依存文字
  )

;;------------------------------------------------------------------------------
;; helm
(defun ec-load-helm-config ()
  (use-package helm
    :diminish (helm-mode helm-migemo-mode)
    :config

    (helm-mode 1)                       ; 常時helm使用
    (helm-migemo-mode 1)
    ;;(helm-dired-bindings 1)

    ;;(setq helm-idle-delay 0.2)        ; 候補を表示するまでの時間
    ;;(setq helm-input-idle-delay 0.1)  ; タイプしてから再描画するまでの時間
    ;;(setq helm-quick-update t)        ; 体感速度向上
    (setq helm-execute-action-at-once-if-one nil) ; 候補が一つの場合になっても自動実行しない
    (setq helm-M-x-fuzzy-match t)                 ; helm-M-x あいまい検索
    (remove-hook 'kill-emacs-hook 'helm-c-adaptive-save-history) ; Emacs終了時に、履歴を保存


    ;; buffer-listにヒストリとカレントディレクトリを追加したオリジナル関数追加
    (bind-key "C-x b" #'(lambda()
                  (interactive)
                  (helm :sources '(helm-source-buffers-list
                                   helm-source-ido-virtual-buffers
                                   helm-source-buffer-not-found
                                   helm-source-file-name-history
                                   helm-source-files-in-current-dir)
                        :buffer "*helm buffers*" :keymap helm-buffer-map)))

    (custom-set-variables '(helm-ff-auto-update-initial-value nil)) ; 自動補完を無効

    (use-package helm-grep)
    (use-package helm-ag
      :config
      (setq helm-ag-base-command "ag --nocolor --nogrou -S")
      :bind (
             ("C-c a" . helm-ag)
             ))
    (use-package helm-projectile
      :config
      (projectile-global-mode t)
      (helm-projectile-on)
      (setq projectile-known-projects-file "~/.emacs.d/tmp/projectile-bookmarks.eld")
      :bind (
             ("C-c p p" . helm-projectile-switch-project)))
    (use-package helm-gtags
      :bind (
             ("<f3>" . helm-gtags-find-tag)    ; 関数の定義場所
             ("S-<f3>" . helm-gtags-pop-stack) ; ひとつ戻る
             ("C-S-g" . helm-gtags-find-rtag)  ; 関数の参照場所
             )
      :config
      (setq helm-gtags-auto-update t)) ; バッファを保存した時にTAGファイル更新
    :bind (
           ("C-c h" . helm-mini)        ; helm起動
           ("C-x C-f" . helm-for-files) ; デフォルトのhelm-find-fileを変更
           ("C-M-z" . helm-resume)      ; 直前のhelm実行結果に復帰する
           ("M-x" . helm-M-x)           ; コマンド実行をhelmに変更
           ("M-y" . helm-show-kill-ring) ; yankをhelm化
           ("C-x C-g" . helm-ghq)       ; ghqのhelmインターフェイス
           :map helm-read-file-map
           ("C-h" . delete-backward-char) ; C-hでバックスペース
           ("TAB" . helm-execute-persistent-action) ; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定する事も可能
           :map helm-find-files-map
           ("C-h" . delete-backward-char) ; C-hでバックスペース
           ("TAB" . helm-execute-persistent-action) ; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定する事も可能
           :map helm-map
           ("C-h" . delete-backward-char) ; helm中はC-hが効かなかったから再定義
           ("C-z" . helm-select-action)))
  )

;;------------------------------------------------------------------------------
;; whitespace
(defun ec-load-whitespace-config ()
  (use-package whitespace
    :diminish (whitespace-mode whitespace-newline-mode global-whitespace-mode)
    :init
    (global-whitespace-mode 1)
    :config
    (setq whitespace-style '(face           ; faceで可視化
                             trailing       ; 行末
                             tabs           ; タブ
                             space-mark
                             tab-mark
                             ))

    (setq whitespace-display-mappings
          '((?\t [?\u00BB ?\t] [?\\ ?\t]))))
  )

;;------------------------------------------------------------------------------
;; coding
(defun ec-load-coding-config ()
  ;; paren
  (show-paren-mode t)                     ; 対応括弧のハイライト
  (setq show-paren-style 'mixed)          ; 括弧が画面外なら内容をハイライト

  ;; indent
  (setq-default indent-tabs-mode nil)     ; タブを使わない
  (setq-default indent-level 4)           ; インデントレベル
  (setq-default tab-width 4)              ; タブ幅

  ;; up/down case
  (put 'upcase-region 'disabled nil)      ; 大文字化の問い合わせ無し
  (put 'downcase-region 'disabled nil)    ; 小文字化の問い合わせ無し

  ;; save place
  (use-package saveplace
    :init
    (setq-default save-place t)             ; 各種ファイルのカーソル位置を記憶
    :config
    (setq save-place-file (concat user-emacs-directory "tmp/save-place"))) ; カーソル位置記憶用ファイル

  ;; 1行ずつスクロールさせる
  (setq scroll-conservatively 35
        scroll-margin 0
        scroll-step 1)
  )

;;------------------------------------------------------------------------------
;; auto-complete
(defun ec-load-auto-complete-config ()
  (use-package auto-complete
    :diminish auto-complete-mode
    :config
    (add-to-list 'ac-dictionary-directories (concat user-emacs-directory "data/auto-complete/dict"))

    (use-package auto-complete-config
      :config
      (use-package pos-tip)

      (setq ac-comphist-file (concat user-emacs-directory "tmp/ac-comphist.dat"))

      ;;(ac-config-default)

      (setq ac-menu-height 20)              ; 補完リストの高さ

      (setq ac-dwim t)                      ; 補完候補が１つの時はそれを採用

      (setq ac-use-comphist t)          ; 補完候補をソート
      (setq ac-auto-show-menu 0.2)      ; 補完リストが表示されるまでの時間
      (setq ac-candidate-limit nil)     ; 補完候補表示を無制限に
      (ac-set-trigger-key "TAB")        ; 補完メニュー表示キー

      (setq ac-use-menu-map t)          ; 補完メニューでmapを有効化

      (bind-key "C-n" 'ac-next ac-menu-map)
      (bind-key "C-p" 'ac-previous ac-menu-map))
    ))

(defun ec-load-company-config ()
  (use-package company
    :diminish company-mode
    :config
    (global-company-mode +1)            ; 基本的にcompany-modeを有効
    (company-quickhelp-mode +1)

    (setq company-idle-delay 0.2)   ; 補完リストが表示されるまでの時間
    (setq company-minimum-prefix-length 1)
    (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

    (defun org-company-insert-candidate (candidate)
      (when (> (length candidate) 0)
        (setq candidate (substring-no-properties candidate))
        (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
            (insert (company-strip-prefix candidate))
          (if (equal company-prefix candidate)
              (company-select-next)
            (delete-region (- (point) (length company-prefix)) (point))
            (insert candidate))
          )))

    (defun org-company-complete-common ()
      (interactive)
      (when (company-manual-begin)
        (if (and (not (cdr company-candidates))
                 (equal company-common (car company-candidates)))
            (company-complete-selection)
          (org-company-insert-candidate company-common))))

    :bind (
           :map company-search-map
                ("M-n" . nil)
                ("M-p" . nil)
                ("C-n" . company-select-next)
                ("C-p" . company-select-previous)
           :map company-active-map
                ("M-n" . nil)
                ("M-p" . nil)
                ("C-n" . company-select-next)
                ("C-p" . company-select-previous)
                ("C-h" . nil)
                ("C-s" . company-filter-candidates)
                ("TAB" . org-company-complete-common)
                )
    )
  )

;;------------------------------------------------------------------------------
;; diff
(defun ec-load-diff-config ()
  (add-hook 'diff-mode-hook
            '(lambda ()
               (diff-auto-refine-mode t)           ; 変更箇所の文字単位で色を付ける

               (set-face-foreground 'diff-added             "#90EE90") ; diff 追加分文字
               (set-face-foreground 'diff-changed           "#FFFF00") ; diff 追加分文字
               (set-face-foreground 'diff-indicator-added   "#90EE90") ; diff 追加分文字
               (set-face-foreground 'diff-indicator-changed "#FFFF00") ; diff 追加分文字
               (set-face-foreground 'diff-indicator-removed "#8B0000") ; diff 追加分文字
               (set-face-foreground 'diff-refine-change     "#000000") ; diff 文字単位での変更箇所文字
               (set-face-background 'diff-refine-change     "#FFFF00") ; diff 文字単位での変更箇所背景
               (set-face-foreground 'diff-removed           "#8B0000") ; diff 削除分文字
               ))
  )

;;------------------------------------------------------------------------------
;; anzu
(defun ec-load-anzu-config ()
  (use-package anzu
    :diminish anzu-mode
    :init
    (global-anzu-mode +1))
  )

;;------------------------------------------------------------------------------
;; auto-highlight-symbol
(defun ec-load-auto-highlight-symbol-config ()
  (use-package auto-highlight-symbol
    :diminish auto-highlight-symbol-mode
    :init
    (global-auto-highlight-symbol-mode))
  )

;;------------------------------------------------------------------------------
;; git-gutter-fringe
(defun ec-load-git-gutter-fringe-config ()
  (use-package git-gutter-fringe
    :diminish (git-gutter-mode)
    :config
    (global-git-gutter-mode 1))
  )

;;------------------------------------------------------------------------------
;; rainbow-mode
(defun ec-load-rainbow-mode-config ()
  (use-package rainbow-mode
    :diminish rainbow-mode
    :config
    (setq rainbow-html-colors t)
    (setq rainbow-x-colors t)
    (setq rainbow-latex-colors t)
    (setq rainbow-ansi-colors t))
  )

;;------------------------------------------------------------------------------
;; rainbow-delimiters
(defun ec-load-rainbow-delimiters-config ()
  (use-package rainbow-delimiters
    :diminish rainbow-delimiters-mode
    :config
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode) ; 括弧の対応を虹色にする

    ;; rainbow-delimitersの色を強調する
    ;; http://d.hatena.ne.jp/murase_syuka/20140815/1408061850
    (require 'cl-lib)
    (require 'color)
    (cl-loop
     for index from 1 to rainbow-delimiters-max-face-count
     do
     (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
       (cl-callf color-saturate-name (face-foreground face) 30))))
  )

;;------------------------------------------------------------------------------
;; align
(defun ec-load-align-config ()
  (use-package align)
  )

;;------------------------------------------------------------------------------
;; pcre2el
(defun ec-load-pcre2el-config ()
  (require 'pcre2el)
  (setq reb-re-syntax 'pcre)              ; re-builderのデフォルトをpcreに変更
  )

;;------------------------------------------------------------------------------
;; original c-style
(defun ec-load-original-c-style-config ()
  (require 'c-style-base)
  (require 'c-style-php)
  )

;;------------------------------------------------------------------------------
;; php-mode
(defun ec-load-php-mode-config ()
  (use-package php-mode
    :config
    (add-hook 'php-mode-hook
              '(lambda ()
                 (c-set-style "c-style-php") ; オリジナルのスタイルを使用
                 (setq comment-start "// ")
                 (setq comment-end   "")
                 (setq comment-start-skip "// *")

                 ;;(require 'company-php)
                 (company-mode t)
                 ;;(add-to-list 'company-backends 'company-ac-php-backend)
                 (add-to-list 'company-backends 'php-extras-company)

                 ;; imenuでAllMethodsを表示しない
                 ;; http://qiita.com/osamu2001/items/511b558e5280dbf2b218
                 (assq-delete-all
                  (car (assoc "All Methods" php-imenu-generic-expression))
                  php-imenu-generic-expression)

                 (rainbow-mode t))
              )))

;;------------------------------------------------------------------------------
;; web-mode
(defun ec-load-web-mode-config ()
  (use-package web-mode
    :mode (
           ("\\.html$" . web-mode)
           ("\\.tpl$" . web-mode)
           ("\\.ctp$" . web-mode)
           ("\\.blade\\.php$" . web-mode)
           )
    :config
    (add-hook 'web-mode-hook
              '(lambda ()
                 (setq web-mode-markup-indent-offset 2) ; HTML
                 (setq web-mode-css-indent-offset 2)    ; CSS
                 (setq web-mode-code-indent-offset 2)   ; JavaScript,PHP
                 (setq web-mode-attr-indent-offset 2)   ; attr改行時のインデント

                 (setq web-mode-style-padding 2)       ; <style>
                 (setq web-mode-script-padding 2)      ; <script>

                 (setq web-mode-enable-auto-pairing nil) ; 自動タグ閉じ
                 (setq web-mode-enable-css-colorization nil) ; RGBをバックグラウンドに反映

                 (setq indent-tabs-mode nil)

                 (setq web-mode-engines-alist
                       '(("blade" . "\\.blade\\."))
                       )

                 (rainbow-mode t)

                 ;; (setq web-mode-ac-sources-alist
                 ;;       '(("css" . (ac-source-css-property))
                 ;;         ("html" . (ac-source-html-attribute-value
                 ;;                    ac-source-html-tag
                 ;;                    ac-source-html-attribute
                 ;;                    ))
                 ;;         ("php" . (
                 ;;                   ac-source-words-in-same-mode-buffers
                 ;;                   ac-source-filename))
                 ;;         )
                 ;;       )
                 )))
  )

;;------------------------------------------------------------------------------
;; sh-mode
(defun ec-load-sh-mode-config ()
  (use-package sh-mode
    :mode (
           ("\\.bash$" . sh-mode)
           ("\\.zsh$" . sh-mode)
           ("zsh\\.d\\/zsh[env|function|rc]" . sh-mode)
           )
    :config
    (add-hook 'sh-mode-hook
              '(lambda ()
                 (c-set-style "original-style")
                 ;;(auto-complete-mode t)
                 )))
  )

;;------------------------------------------------------------------------------
;; cmd-mode
(defun ec-load-cmd-mode-config ()
  (use-package cmd-mode
    :mode (
           ("\\.[bB][aA][tT]$" . cmd-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; markdown
(defun ec-load-markdown-mode-config ()
  (use-package markdown-mode
    :mode (
           ("\\.md$" . gfm-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; textile-mode
(defun ec-load-textile-mode-config ()
  (use-package textile-mode
    :mode (
           ("\\.textile$" . textile-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; yaml-mode
(defun ec-load-yaml-mode-config ()
  (use-package yaml-mode
    :mode (
           ("\\.yml$" . yaml-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; json-mode
(defun ec-load-json-mode-config ()
  (use-package json-mode
    :mode (
           ("\\.json$" . json-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; csv-mode
(defun ec-load-csv-mode-config ()
  (use-package csv-mode
    :mode (
           ("\\.csv$" . csv-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; tsv-mode
(defun ec-load-tsv-mode-config ()
  (use-package tsv-mode
    :mode (
           ("\\.tsv$" . tsv-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; css-mode
(defun ec-load-css-mode-config ()
  (use-package css-mode
    :mode (
           ("\\.css$" . css-mode)
           )
    :config
    (add-hook 'css-mode-hook 'rainbow-mode))
  )

;;------------------------------------------------------------------------------
;; scss-mode
(defun ec-load-scss-mode-config ()
  (use-package scss-mode
    :mode (
           ("\\.scss$" . scss-mode)
           )
    :config
    (add-hook 'scss-mode-hook 'rainbow-mode))
  )

;;------------------------------------------------------------------------------
;; sass-mode
(defun ec-load-sass-mode-config ()
  (use-package sass-mode
    :mode (
           ("\\.sass$" . sass-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; js2-mode
(defun ec-load-js-mode-config ()
  (use-package js2-mode
    :mode (
           ("\\.js$" . js2-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; ssh-config-mode
(defun ec-load-ssh-config-mode-config ()
  (use-package ssh-config-mode
    :mode (
           ("/\\.ssh\\/config\\" . ssh-config-mode)
           ("/sshd?_config\\" . ssh-config-mode)
           ("/known_hosts\\" . ssh-known-hosts-mode)
           ("/authorized_keys2?\\" . ssh-authorized-keys-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; gitconfig-mode
(defun ec-load-gitconfig-mode-config ()
  (use-package gitconfig-mode
    :mode (
           ("\\.gitconfig.*$" . gitconfig-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; gitignore-mode
(defun ec-load-gitignore-mode-config ()
  (use-package gitignore-mode
    :mode (
           ("\\.gitignore.*$" . gitignore-mode)
           ))
  )

;;------------------------------------------------------------------------------
;; org-mode
(defun ec-load-org-mode-config ()
  (require 'org-install)
  (setq org-log-done t)

  ;; メモファイルの保存先
  (setq org-directory "~/.emacs.d/etc/org/")

  ;; org-default-notes-fileのファイル名
  (setq org-default-notes-file (expand-file-name "memo.org" org-directory))

  ;; 画像をインライン表示
  (setq org-startup-with-inline-images t)
  (add-hook 'org-mode-hook 'turn-on-iimage-mode)


  ;; １階層下・上の見出し・項目を入力する。
  (require 'org)
  (defun org-insert-upheading (arg)
    "１レベル上の見出しを入力する。"
    (interactive "P")
    (org-insert-heading arg)
    (cond ((org-on-heading-p) (org-do-promote))
          ((org-at-item-p) (org-indent-item -1))))
  (defun org-insert-heading-dwim (arg)
    "現在と同じレベルの見出しを入力する。
C-uをつけると１レベル上、C-u C-uをつけると１レベル下の見出しを入力する。"
    (interactive "P")
    (case arg
      (4  (org-insert-subheading nil))
      (16 (org-insert-upheading  nil))
      (t  (org-insert-heading nil))))
  (define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)

  ;; ハイパーリンクの作成
  (global-set-key (kbd "C-c l") 'org-store-link)

  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  )

;;------------------------------------------------------------------------------
;; tabbar
(defun ec-load-tabbar-config ()
  (require 'tabbar)
  (tabbar-mode)

  (tabbar-mwheel-mode nil)                 ; マウスホイール無効
  (setq tabbar-buffer-groups-function nil) ; グループ無効
  (setq tabbar-use-images nil)             ; 画像を使わない

  (global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
  (global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)

  ;; 左側のボタンを消す
  (dolist (btn '(tabbar-buffer-home-button
                 tabbar-scroll-left-button
                 tabbar-scroll-right-button))
    (set btn (cons (cons "" nil)
                   (cons "" nil))))

  (setq tabbar-separator '(0.5))          ; タブのセパレーターの長さ

  ;; 外観変更
  (set-face-attribute 'tabbar-default nil :family "Ricty for Powerline" :background "black" :foreground "gray72" :height 1.0)
  (set-face-attribute 'tabbar-unselected nil :background "black" :foreground "gray72" :box nil)
  (set-face-attribute 'tabbar-selected nil :background "gray32" :foreground "light green" :box nil :weight 'bold)
  (set-face-attribute 'tabbar-modified nil :background "black" :foreground "red" :box nil)
  (set-face-attribute 'tabbar-selected-modified nil :box nil)
  (set-face-attribute 'tabbar-button nil :box nil)
  (set-face-attribute 'tabbar-separator nil :height 1.5)

  ;; 表示するバッファ
  (setq tabbar-buffer-list-function
        #'(lambda ()
            (delq nil
                  (mapcar #'(lambda (b)
                              (cond
                               ((eq (current-buffer) b) b)
                               ((buffer-file-name b) b)
                               ((char-equal ?\ (aref (buffer-name b) 0)) nil)
                               ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
                               ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の*で始まるバッファは表示しない
                               ((buffer-live-p b) b)))
                          (buffer-list)))))
  )

;;------------------------------------------------------------------------------
;; flycheck
(defun ec-load-flycheck-config ()
  (use-package flycheck
    :init
    (global-flycheck-mode)
    (flycheck-pos-tip-mode)
    :config
    (progn
      (custom-set-variables '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
    (setq flycheck-pos-tip-timeout nil)
    )
  )

;;------------------------------------------------------------------------------
;; auto-insert
(defun ec-load-auto-insert-config ()
  (auto-insert-mode t)

  ;; テンプレートディレクトリ指定
  (setq auto-insert-directory "~/.emacs.d/data/auto-insert/")

  ;; テンプレートリスト
  (setq auto-insert-alist
        (append '(
                  ("\\.class.php" . "php/class.php") ;; クラス
                  ("\\Test.php" . "php/test.php") ;; PHPUnitテストクラス
                  ("\\.php" . "php/class.php") ;; 通常スクリプト
                  ("\\.pl" . "perl/script.pl") ;; 通常スクリプト
                  ("\\.pm" . "perl/class.pl") ;; クラス
                  ("\\.cgi" . "perl/index.pl") ;; index
                  )
                auto-insert-alist))
  )

;;------------------------------------------------------------------------------
;; navi2ch
(defun ec-load-navi2ch-config ()
  (autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

  (setq navi2ch-directory "~/.emacs.d/data/navi2ch") ; キャッシュファイル等の置き場

  (setq navi2ch-list-stay-list-window t)  ; 3ペインモードで見る

  (setq navi2ch-list-window-width 40)     ; 板一覧の横幅
  (setq navi2ch-list-indent-width 2)      ; 板一覧のインデント幅
  (setq navi2ch-board-window-height 15)   ; スレ一覧の高さ
  (setq navi2ch-bm-subject-width 80)      ; 各スレ題名の幅
  (setq navi2ch-bm-number-width 4)        ; 各スレ番号の幅

  (setq navi2ch-article-message-separator-width '(window-width)) ; レス区切りの幅

  (setq navi2ch-mona-enable t)            ; モナーフォント有効化
  (setq navi2ch-message-save-sendlog t)   ; 書き込みログ有効化

  ;; (add-to-list 'navi2ch-list-navi2ch-category-alist
  ;;               navi2ch-message-sendlog-board)

  (setq navi2ch-message-user-name "")        ; デフォルトの名前
  (setq navi2ch-message-mail-address "sage") ; デフォルトのメールアドレス

  (setq navi2ch-board-insert-subject-with-diff t) ; Board モードのレス数欄にレスの増加数を表示する
  (setq navi2ch-board-insert-subject-with-unread t) ; Board モードのレス数欄にレスの未読数を表示する

  (setq navi2ch-article-exist-message-range '(1 . 1000)) ; 既読スレは全て表示
  (setq navi2ch-article-new-message-range '(1000 . 1))   ; 未読スレは全て表示
  )

;;------------------------------------------------------------------------------
;; open-junk-file
(defun ec-load-open-junk-file-config ()
  (use-package open-junk-file
    :config
    (setq open-junk-file-format "~/.emacs.d/data/junk/%Y-%m/%d-%H%M%S.")
    :bind (
           ("C-, C-," . open-junk-file)
           ))
  )

;;------------------------------------------------------------------------------
;; magit
(defun ec-load-magit-config ()
  (define-key global-map (kbd "C-x m") 'magit-status)

  (eval-after-load 'magit
    '(progn
       (set-face-background 'magit-item-highlight "#202020")
       (set-face-foreground 'magit-diff-add "#40FF40")
       (set-face-background 'magit-diff-add "#000000")
       (set-face-foreground 'magit-diff-del "#FF4040")
       (set-face-background 'magit-diff-del "#000000")
       (set-face-foreground 'magit-diff-file-header "#2020FF")
       (set-face-background 'magit-diff-file-header "#404040")
       (set-face-background 'magit-diff-hunk-header "#404040")
       ))
  )

;;------------------------------------------------------------------------------
;; google-translate
(defun ec-load-google-translate-config ()
  (require 'google-translate)
  (require 'google-translate-default-ui)
  (defvar google-translate-japanese-chars
    "[ぁ-んァ-ヶ々〇〻\u3220-\u3244\u3280-\u32B0\u3400-\u9FFF\uF900-\uFAFF\U00020000-\U0002FFFF]"
    "これらの文字が含まれているときは日本語とみなす") ;いい加減

  (defun google-translate-get-string (arg)
    (cond ((stringp arg) arg)
          ((= arg 4)                      ; C-u
           (thing-at-point 'paragraph))
          ((= arg 16)                     ; C-u C-u
           (thing-at-point 'word))
          ((= arg 64)
           (read-string "Google Translate: "))
          ((use-region-p)                 ; リージョン指定
           (buffer-substring (region-beginning) (region-end)))
          (t                              ; デフォルト
           (thing-at-point 'sentence))))

  (defun google-translate-enja-or-jaen (arg)
    "regionか現在位置の単語を翻訳する。C-u付きでquery指定も可能"
    (interactive "p")
    (let* ((string (google-translate-get-string arg))
           (japanesep (string-match
                       google-translate-japanese-chars
                       string)))
      (run-at-time 0.1 nil 'deactivate-mark)
      (google-translate-translate
       (if japanesep "ja" "en")
       (if japanesep "en" "ja")
       string)))

  (push '("*Google Translate*" :height 0.5 :stick t) popwin:special-display-config)

  (global-set-key (kbd "C-M-t") 'google-translate-enja-or-jaen)
  )

;;------------------------------------------------------------------------------
;; ユーティリティ
(defun ec-load-utility-config ()
  ;; カーソル位置のフェースを調べる関数
  (defun describe-face-at-point ()
    "Return face used at point."
    (interactive)
    (message "%s" (get-char-property (point) 'face)))


  ;; 日付挿入 (Changesとかで使う)
  (defun current-insert-date ()
    (interactive)
    "現在の日付を挿入する"
    (insert (format-time-string "%Y-%m-%d %R:%S" (current-time))))


  ;; 行頭、行の最初のインデント位置、行頭を繰り返す
  (defun repeat-line-head (arg)
    (interactive "^p")
    (cond
     ((bolp)
      (call-interactively 'back-to-indentation))
     (t
      (move-beginning-of-line arg))))


  ;; 全てのバッファーを閉じる
  (defun kill-all-buffers ()
    (interactive)
    "全てのバッファーを閉じる"
    (loop for buffer being the buffers
          do (kill-buffer buffer)))
  )

;;------------------------------------------------------------------------------
;; テーマ
(defun ec-load-themes-config ()
  (cond ((>= emacs-major-version 24)
         ;; Emacs24から実装されたThemeフレームワークを利用
         (setq custom-theme-directory "~/.emacs.d/data/themes/")
         (load-theme 'feel-at-home t)
         (enable-theme 'feel-at-home)
         )
        )
  (set-face-bold-p 'font-lock-warning-face nil) ; 定数
  )

;;------------------------------------------------------------------------------
;; 他のキーバインド
(defun ec-load-keybind-config ()
  (bind-keys
   ("C-h" . backward-delete-char)
   ("C-x C-h" . help-command)
   ("C-x C-z" . nil)
   ("C-x C-c" . nil)
   ("C-t" . other-window)
   ;;([165] . [92])                       ; Google日本語入力の設定で対応する
   )

  ;; 行頭、行の最初のインデント位置、行頭を繰り返す
  (bind-key "C-a" #'(lambda (arg)
                      (interactive "^p")
                      (cond
                       ((bolp)
                        (call-interactively 'back-to-indentation))
                       (t
                        (move-beginning-of-line arg)))))
  )

;;------------------------------------------------------------------------------
;; Emacs Server
(defun ec-load-server-config ()
  (use-package server
    :config
    (setq server-socket-dir "~/.emacs.d/tmp/server")
    (unless (server-running-p)              ; 複数サーバー起動を防ぐ
      (server-start)))
  )
;;----------------------------------------------------------------------
;; 実行環境判別
;; http://d.hatena.ne.jp/hito-d/20060220#1140445790
;;----------------------------------------------------------------------
;; OSを判別
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (or (equal system-type 'usg-unix-v)
          (or  (equal system-type 'berkeley-unix)
               (equal system-type 'cygwin)))))
(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-system-v
  (equal system-type 'usg-unix-v))
(defvar run-bsd
  (equal system-type 'berkeley-unix))
(defvar run-cygwin ;; cygwinもunixグループにしておく
  (equal system-type 'cygwin))
(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))
(defvar run-darwin (equal system-type 'darwin))

;; 実行OS名設定
(cond
 (run-w32
  (setq run-os-name "windows"))
 ((or run-unix run-linux run-cygwin)
  (setq run-os-name "linux"))
 (run-darwin
  (setq run-os-name "mac")))

;; WindowSystem名設定
(cond
 ((null window-system)
  (setq run-window-system-name "terminal"))
 (t
  (setq run-window-system-name window-system)))

;; Emacsの種類とバージョンを判別
(defvar run-emacs20
  (and (equal emacs-major-version 20)
       (null (featurep 'xemacs))))
(defvar run-emacs21
  (and (equal emacs-major-version 21)
       (null (featurep 'xemacs))))
(defvar run-emacs22
  (and (equal emacs-major-version 22)
       (null (featurep 'xemacs))))
(defvar run-emacs23
  (and (equal emacs-major-version 23)
       (null (featurep 'xemacs))))
(defvar run-emacs24
  (and (equal emacs-major-version 24)
       (null (featurep 'xemacs))))
(defvar run-meadow (featurep 'meadow))
(defvar run-meadow1 (and run-meadow run-emacs20))
(defvar run-meadow2 (and run-meadow run-emacs21))
(defvar run-meadow3 (and run-meadow run-emacs22))
(defvar run-xemacs (featurep 'xemacs))
(defvar run-xemacs-no-mule
  (and run-xemacs (not (featurep 'mule))))
(defvar run-carbon-emacs (and run-darwin window-system))


(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rainbow-mode htmlize ssh-config-mode gitconfig-mode gitignore-mode csv-mode helm-dired-recent-dirs))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
