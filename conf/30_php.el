(require 'php-mode)
(require 'phpdoc)

(setq php-mode-force-pear t)          ; PEAR規約設定

;; hook
(add-hook 'php-mode-hook
          '(lambda ()
             (eldoc-mode t)
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

             (setq comment-start "// ")
             (setq comment-end   "")
             (setq comment-start-skip "// *")

             (setq tab-width 4)                       ; タブ幅
             (setq indent-tabs-mode nil)              ; インデントにタブを利用しない
             (setq c-basic-offset 4)                  ; c-set-offsetに特殊文字を入れた場合のoffset値

             ;; function hoge (
             ;;     x, // <- arglist-intro
             ;;     y  // <- arglist-cont
             ;; ) // <-arglist-close
             (c-set-offset 'arglist-intro 4)
             (c-set-offset 'arglist-cont-nonempty 4)
             (c-set-offset 'arglist-close 0)

             ;; switch(c) {
             ;;     case 'a': // <- case-label
             ;; };
             (c-set-offset 'case-label '+)
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

