;; (iswitchb-mode 1)

;; ;; キーボードでバッファの切り替え
;; (add-hook 'iswitchb-define-mode-map-hook
;;           'iswitchb-my-keys)

;; (defun iswitchb-my-keys ()
;;   "Add my keybindings for iswitchb."
;;   (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
;;   (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
;;   (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
;;   (define-key iswitchb-mode-map " " 'iswitchb-next-match)
;;   (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
;;   )

;; ;; 選択しているバッファを表示する
;; (defadvice iswitchb-exhibit
;;   (after
;;    iswitchb-exhibit-with-display-buffer
;;    activate)
;;   "選択している buffer を window に表示してみる。"
;;   (when (and
;;          (eq iswitchb-method iswitchb-default-method)
;;          iswitchb-matches)
;;     (select-window
;;      (get-buffer-window (cadr (buffer-list))))
;;     (let ((iswitchb-method 'samewindow))
;;       (iswitchb-visit-buffer
;;        (get-buffer (car iswitchb-matches))))
;;     (select-window (minibuffer-window))))

;; ;; migemoでバッファを選べる
;; (setq iswitchb-regexp t)
;; (setq iswitchb-use-migemo-p t)
;; (defadvice iswitchb-get-matched-buffers
;;   (before iswitchb-use-migemo activate)
;;   "iswitchb で migemo を使ってみる。"
;;   (when iswitchb-use-migemo-p
;;     (ad-set-arg
;;      0 (migemo-get-pattern
;;         (ad-get-arg 0)))))
