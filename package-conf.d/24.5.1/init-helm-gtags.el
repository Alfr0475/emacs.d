(define-key global-map (kbd "<f3>") 'helm-gtags-find-tag)
(define-key global-map (kbd "C-S-g") 'helm-gtags-find-rtag)

;; gtags自動更新
(setq helm-gtags-auto-update t)
