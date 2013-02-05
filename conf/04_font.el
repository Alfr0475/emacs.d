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
;;------------------------------------------------------------------------------

;;------------------------------------------------------------------------------
;; 環境別フォント設定
;;------------------------------------------------------------------------------
(cond ((and window-system run-emacs24 run-w32)
       ;; Windows環境でのGUI版Emacs24系
       (set-default-font "Consolas-11")
       (set-fontset-font (frame-parameter nil 'font)
                         'japanese-jisx0208
                         '("ＭＳ ゴシック" . "unicode-bmp")) ; 全角文字
       (set-fontset-font (frame-parameter nil 'font)
                         'katakana-jisx0201
                         '("ＭＳ ゴシック" . "unicode-bmp")) ; 半角カタカナ
       (set-fontset-font (frame-parameter nil 'font)
                         'cp932
                         '("ＭＳ ゴシック" . "unicode-bmp")) ; 機種依存文字
       )

      ((and window-system run-emacs23 run-w32)
       ;; Windows環境でのGUI版Emacs23系
       (set-default-font "Consolas-11")
       (set-fontset-font (frame-parameter nil 'font)
                         'japanese-jisx0208
                         '("ＭＳ ゴシック" . "unicode-bmp")) ; 全角文字
       (set-fontset-font (frame-parameter nil 'font)
                         'katakana-jisx0201
                         '("ＭＳ ゴシック" . "unicode-bmp")) ; 半角カタカナ
       (set-fontset-font (frame-parameter nil 'font)
                         'cp932
                         '("ＭＳ ゴシック" . "unicode-bmp")) ; 機種依存文字
       )
      ;; ((and window-system run-emacs22 run-w32)
      ;;  ;; Windows環境でのGUI版Emacs22系
      ;;  )
      ;; ((and window-system run-emacs21 run-w32)
      ;;  ;; Windows環境でのGUI版Emacs21系
      ;;  )
      ;; ((and window-system run-emacs23 run-linux)
      ;;  ;; Linux環境でのGUI版Emacs23系
      ;;  )
      ;; ((and window-system run-emacs22 run-linux)
      ;;  ;; Linux環境でのGUI版Emacs22系
      ;;  )
      ;; ((and window-system run-emacs21 run-linux)
      ;;  ;; Linux環境でのGUI版Emacs21系
      ;;  )
      ;; ((and run-meadow3 run-w32)
      ;;  ;; Windows環境でのMeadow3
      ;;  )
      )

;;(global-font-lock-mode t)

;;------------------------------------------------------------------------------
;; IME設定
;;------------------------------------------------------------------------------
(cond (
       (and window-system run-w32
            (and (equal emacs-major-version 23)
                 (equal emacs-minor-version 4)))
       ;; Windows環境でのIME設定
       (setq default-input-method "W32-IME")   ; 標準IMEの設定
       (setq-default w32-ime-mode-line-state-indicator "[--]") ; 初期表示
       (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]")) ; モードラインの表示をIMEと連動
       (w32-ime-initialize)                    ; IMEの初期化処理
       )
      ;; ((and window-system run-linux)
      ;;  ;; Linux環境でのIME系設定
      ;;  )
      )
