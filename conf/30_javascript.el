(when (load "js2" t)
  (require 'js)
  (setq js2-bounce-indent-flag nil
        js2-mirror-mode nil
        )

  ;; インデントしたときにスペースを除いた行頭にポイントが移動
  (defun indent-and-back-to-indentation ()
    (interactive)
    (indent-for-tab-command)
    (let ((point-of-indentation
           (save-excursion
             (back-to-indentation)
             (point))))
      (skip-chars-forward "\s " point-of-indentation)))

  (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
  (define-key js2-mode-map "\C-m" 'newline-and-indent)

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

  ;; ejacs設定
  (autoload 'js-console "js-console" nil t)
  (defun js-console-execute-region (start end)
    "Execute region"
    (interactive "r")
    (let ((buf-name (buffer-name (current-buffer))))
      (copy-region-as-kill start end)
      (switch-to-buffer-other-window "*js*")
      (js-console-exec-input (car kill-ring))
      (switch-to-buffer-other-window buf-name)))
  (defun run-js-console-and-split-window ()
    "Run js-console and split window horizontally."
    (interactive)
    (split-window-horizontally)
    (js-console)
    (other-window 1)
    )

  ;; js-modeのタブ設定を利用する
  (add-hook 'js2-mode-hook
            '(lambda ()
               (require 'js)
               (setq js-indent-level 4
                     js-expr-indent-offset 4
                     indent-tabs-mode nil
                     )

               (moz-minor-mode 1) ;; 要moz.el
               (local-set-key "\C-c\C-j" 'run-js-console-and-split-window)
               (local-set-key "\C-cr" 'js-console-execute-region)

               ;; case用のインデント関数
               (defun my-js-indent-line ()
                 (interactive)
                 (let* ((parse-status (save-excursion (syntax-ppss (point-at-bol))))
                        (offset (- (current-column) (current-indentation)))
                        (indentation (js--proper-indentation parse-status)))
                   (back-to-indentation)
                   (if (looking-at "case\\s-")
                       (indent-line-to (+ indentation 2))
                     (js-indent-line))
                   (when (> offset 0) (forward-char offset))))
               (set (make-local-variable 'indent-line-function) 'my-js-indent-line)))

  )


;; ; fixing indentation
;; ; refer to http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode

;; (defun my-js2-indent-function ()
;;   (interactive)
;;   (save-restriction
;;     (widen)
;;     (let* ((inhibit-point-motion-hooks t)
;;            (parse-status (save-excursion (syntax-ppss (point-at-bol))))
;;            (offset (- (current-column) (current-indentation)))
;;            (indentation (js-proper-indentation parse-status))
;;            node)

;;       (save-excursion

;;         ;; I like to indent case and labels to half of the tab width
;;         (back-to-indentation)
;;         (if (looking-at "case\\s-")
;;             (setq indentation (+ indentation (/ js-indent-level 2))))

;;         ;; consecutive declarations in a var statement are nice if
;;         ;; properly aligned, i.e:
;;         ;;
;;         ;; var foo = "bar",
;;         ;;     bar = "foo";
;;         (setq node (js2-node-at-point))
;;         (when (and node
;;                    (= js2-NAME (js2-node-type node))
;;                    (= js2-VAR (js2-node-type (js2-node-parent node))))
;;           (setq indentation (+ 4 indentation))))

;;       (indent-line-to indentation)
;;       (when (> offset 0) (forward-char offset)))))

;; (defun my-indent-sexp ()
;;   (interactive)
;;   (save-restriction
;;     (save-excursion
;;       (widen)
;;       (let* ((inhibit-point-motion-hooks t)
;;              (parse-status (syntax-ppss (point)))
;;              (beg (nth 1 parse-status))
;;              (end-marker (make-marker))
;;              (end (progn (goto-char beg) (forward-list) (point)))
;;              (ovl (make-overlay beg end)))
;;         (set-marker end-marker end)
;;         (overlay-put ovl 'face 'highlight)
;;         (goto-char beg)
;;         (while (< (point) (marker-position end-marker))
;;           ;; don't reindent blank lines so we don't set the "buffer
;;           ;; modified" property for nothing
;;           (beginning-of-line)
;;           (unless (looking-at "\\s-*$")
;;             (indent-according-to-mode))
;;           (forward-line))
;;         (run-with-timer 0.5 nil '(lambda(ovl)
;;                                    (delete-overlay ovl)) ovl)))))

;; (defun my-js2-mode-hook ()
;;   ;;(require 'js)
;;   (setq js2-indent-level 2
;;         indent-tabs-mode nil
;;         c-basic-offset 2
;;         js2-mirror-mode nil)
;;   (c-toggle-auto-state 0)
;;   (c-toggle-hungry-state 1)
;;   (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
;;   ; (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
;;   (define-key js2-mode-map "\C-\M-\\"
;;     '(lambda()
;;        (interactive)
;;        (insert "/* -----[ ")
;;        (save-excursion
;;          (insert " ]----- */"))
;;        ))
;;   (define-key js2-mode-map "\C-m" 'newline-and-indent)
;;   ; (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
;;   ; (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
;;   (define-key js2-mode-map "\C-\M-q" 'my-indent-sexp)
;;   (if (featurep 'js2-highlight-vars)
;;       (js2-highlight-vars-mode))
;;   (message "My JS2 hook"))

;; (add-hook 'js2-mode-hook 'my-js2-mode-hook)
