;; JavaScript
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; ssh config
(add-to-list 'auto-mode-alist '("\\.ssh\\/config$" . ssh-config-mode))

;; git config
(add-to-list 'auto-mode-alist '("\\.gitconfig.*$" . gitconfig-mode))

;; git ignore
(add-to-list 'auto-mode-alist '("\\.gitignore.*$" . gitignore-mode))
