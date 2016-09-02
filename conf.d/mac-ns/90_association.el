;; JavaScript
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; HTML
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))

;; Shell Script
(add-to-list 'auto-mode-alist '("\\.bash\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

;; batch
(add-to-list 'auto-mode-alist '("\\.[bB][aA][tT]$" . cmd-mode))

;; markdown
(setq auto-mode-alist (cons '("\\.md" . gfm-mode) auto-mode-alist))

;; textile
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))

;; yaml
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
