(add-to-list 'auto-mode-alist '("\\.bash\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

(add-hook 'sh-mode-hook
          '(lambda ()
             (c-set-style "original-style")
             (auto-complete-mode t)
             ))
