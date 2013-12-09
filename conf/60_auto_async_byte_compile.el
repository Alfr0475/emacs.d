;; auto-async-byte-compile
(require 'auto-async-byte-compile)

;;(setq auto-async-byte-compile-exclude-file-regexp "") ; 自動コンパイルを無効にするファイル名の正規表現
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
