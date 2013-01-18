;; grep
(require 'grep)
;; (setq grep-command-before-query "grep -n -r -e ")
;; (defun grep-default-command ()
;;   (if current-prefix-arg
;;       (let ((grep-command-before-target
;;              (concat grep-command-before-query
;;                      (shell-quote-argument (grep-tag-default)))))
;;         (cons (if buffer-file-name
;;                   (concat grep-command-before-target
;;                           " *."
;;                           (file-name-extension buffer-file-name))
;;                 (concat grep-command-before-target " ."))
;;               (+ (length grep-command-before-target) 1)))
;;     (car grep-command)))
;; (setq grep-command (cons (concat grep-command-before-query " .")
;;                          (+ (length grep-command-before-query) 1)))

;; grepをUTF-8に
(defadvice grep (around grep-coding-setup activate)
  (let ((coding-system-for-read 'utf-8))
    ad-do-it))

;; wgrep
;; grep結果上で内容を編集
(require 'wgrep)

