;;(require 'phpdoc)

; (setq php-mode-force-pear t)          ; PEAR規約設定

;; hook
(add-hook 'php-mode-hook
          '(lambda ()
             (c-set-style "original-style") ; オリジナルのスタイルを使用
             (setq comment-start "// ")
             (setq comment-end   "")
             (setq comment-start-skip "// *")
             (setq indent-tabs-mode nil)

             ;; auto-completionのphp用設定
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-map (kbd "\C-o") 'phpcmp-complete)
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list ac-sources '(
                                         ac-source-php-completion
                                         ac-source-words-in-same-mode-buffers
                                         ac-source-filename
                                         ))
               (auto-complete-mode t))
             ))

;; 補完機能付きマニュアル検索
(defun php-completing-search-documentation ()
  "Search PHP documentation for the symbol user specified."
  (interactive)
  (let* ((default (current-word t))
         (pattern (completing-read
                   (format "PHP symbol {`%s'}: " (or default ""))
                   (php-completion-table))))
    (browse-url
     (concat php-search-url (if (string= pattern "") default pattern)))))

(define-key php-mode-map "\C-c\C-f" 'php-completing-search-documentation)

