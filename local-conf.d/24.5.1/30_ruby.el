;; ruby-mode

;; RSense
(cond ((and run-linux)
       (setq rsense-home (expand-file-name "~/contrib/rsense/"))
       (require 'rsense)
       (setq rsense-rurema-home "~/data/rurema/ruby-refm-1.9.3-dynamic-20120829") ; リファレンスパスの指定
))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)                 ; タブサイズ
             (setq ruby-indent-level tab-width) ; インデントサイズ
             (setq ruby-deep-indent-paren-style nil) ; 引数とかを改行して並べた時にインデントを括弧に合わせない

             (cond ((and run-linux)
                    (add-to-list 'ac-sources 'ac-source-rsense-method)
                    (add-to-list 'ac-sources 'ac-source-rsense-constant)
                    ))
             ))

;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)    ; ミニバッファに表示し、かつオーバレイする
