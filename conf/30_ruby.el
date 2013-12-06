;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; RSense
(require 'rsense)

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)                 ; タブサイズ
             (setq ruby-indent-level tab-width) ; インデントサイズ
             (setq ruby-deep-indent-paren-style nil) ; 引数とかを改行して並べた時にインデントを括弧に合わせない

             (add-to-list 'ac-sources 'ac-source-rsense-method)
             (add-to-list 'ac-sources 'ac-source-rsense-constant)
             ))

(setq rsense-rurema-home "~/.emacs.d/data/rurema/ruby-refm-1.9.3-dynamic-20120829") ; リファレンスパスの指定

;; ruby-electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)    ; ミニバッファに表示し、かつオーバレイする

