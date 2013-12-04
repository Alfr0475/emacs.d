;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; ruby-electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)    ; ミニバッファに表示し、かつオーバレイする

