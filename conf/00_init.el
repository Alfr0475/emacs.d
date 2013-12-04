;; current
(cd "~/")                               ; デフォルトディレクトリ

(cond ((and run-w32)
       ;; encode
       (require 'cp5022x)
       ))

(set-language-environment "Japanese")   ; 言語設定
(prefer-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)

(cond ((and run-w32)
       (setq file-name-coding-system 'cp932)
       (setq default-file-name-coding-system 'cp932)
       )
      ((and run-linux)
       (setq file-name-coding-system 'utf-8)
       )
      )

;; (set-clipboard-coding-system 'utf-8) ; クリップボードが文字化けするのでコメントアウト
(set-charset-priority 'ascii
                      'japanese-jisx0208
                      'latin-jisx0201
                      'katakana-jisx0201
                      'iso-8859-1
                      'cp1252
                      'unicode)
(set-coding-system-priority 'utf-8
                            'euc-jp
                            'iso-2022-jp
                            'cp932)

;; system
(tool-bar-mode -1)                      ; ツールバー非表示
(menu-bar-mode -1)                      ; メニュー非表示
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


;; C-x C-C で終了するキーバインドを無効にしたのでEmacsを終了するaliase追加
(defalias 'exit-emacs 'save-buffers-kill-emacs)
