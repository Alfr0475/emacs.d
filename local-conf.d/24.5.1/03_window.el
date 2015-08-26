;; window
(if window-system
    (progn
      (set-scroll-bar-mode nil)         ; スクロールバー非表示
      (setq ns-pop-up-frames nil)       ; 複数起動防止
      (define-key global-map [ns-drag-file] 'ns-find-file) ; D&Dの挙動をファイルを開く操作に変更
      ))

;; title
(require 'uniquify)                     ; 同名ファイル等はディレクトリパスもつける
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*") ; *scratch*等を省く
