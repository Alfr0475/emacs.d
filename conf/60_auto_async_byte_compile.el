;; auto-async-byte-compile
(require 'auto-async-byte-compile)

;;(setq auto-async-byte-compile-exclude-file-regexp "") ; 自動コンパイルを無効にするファイル名の正規表現
(add-hook 'emacs-lisp-mode-mode-hook 'enable-auto-async-byte-compile-mode)

;; auto-async-byte-compileのバッファをpopwinでポップアップする
;;(setq display-buffer-function 'popwin:display-buffer)

;;(push '(" *auto-async-byte-compile*" :height 14 :position bottom :noselect t) popwin:special-display-config)
;;(push '("*VC-log*" :height 10 :position bottom) popwin:special-display-config)
