(require 'zencoding-mode)
(add-hook 'sgml-mode-hook (lambda () (zencoding-mode 1)))
(add-hook 'html-mode-hook (lambda () (zencoding-mode 1)))
(define-key zencoding-mode-keymap [C-return] 'zencoding-expand-yas)
(setq auto-mode-alist
      (append '(
                ("\\.tpl$" . html-mode)
                )
              auto-mode-alist))
