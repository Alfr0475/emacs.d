(require 'auto-complete-config)
;; (require 'auto-complete-yasnippet)
(require 'pos-tip)

(setq ac-comphist-file "~/.emacs.d/tmp/ac-comphist.dat")

(add-to-list 'ac-dictionary-directories "~/.emacs.d/data/auto-complete/dict")

(ac-config-default)

;; (setq ac-auto-start 1)                ; 補完を開始する文字数
(setq ac-auto-show-menu 0.2)          ; 補完リストが表示されるまでの時間

;; 補完メニュー表示キー
(ac-set-trigger-key "TAB")

;; 補完メニュー操作
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; 補完リスト設定追加
(defun ac-php-mode-setup ()
  (setq ac-sources (append '(ac-source-yasnippet) ac-sources)))
(add-hook 'php-mode-hook 'ac-php-mode-setup)
