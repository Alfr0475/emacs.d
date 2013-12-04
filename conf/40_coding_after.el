;; ;; mmm-mode
;; (require 'mmm-mode)

;; (setq mmm-global-mode 'maybe)               ; 使用タイミング      t:nil:maybe
;; (setq mmm-submode-decoration-level 0)       ; submodeの装飾レベル 0:1:2
;; (invert-face 'mmm-default-submode-face nil) ; 前景色と背景色の入れ替え
;; (setq mmm-font-lock-available-p t)          ; font-lockを有効化

;; ;; html + javascript
;; (mmm-add-classes
;;  '((mmm-javascript
;;     :submode javascript-mode
;;     :front "<script[^>]*>[^<]"
;;     :front-offset -1
;;     :back "\n?[ \t]*</script>")))
;; (mmm-add-mode-ext-class nil "\\.html?\\'" 'mmm-javascript)

;; ;; html + css
;; (mmm-add-classes
;;  '((mmm-css
;;     :submode css-mode
;;     :front "<style[^>]*>"
;;     :back "\n?[ \t]*</style>")))
;; (mmm-add-mode-ext-class nil "\\.html?\\'" 'mmm-css)

;; インデントの改善
;; (defun save-mmm-c-locals ()
;;   (with-temp-buffer
;;     (php-mode)
;;     (dolist (v (buffer-local-variables))
;;       (when (string-match "\\`c-" (symbol-name (car v)))
;;         (add-to-list 'mmm-save-local-variables `(,(car v) nil, mmm-c-derived-modes))))))
;; (save-mmm-c-locals)
