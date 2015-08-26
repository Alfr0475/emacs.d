(require 'web-mode)
(require 'ac-html)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode))

(defun web-mode-hook ()
  (add-to-list 'ac-modes 'web-mode)

  (setq web-mode-markup-indent-offset 4) ; HTML
  (setq web-mode-css-indent-offset 4)    ; CSS
  (setq web-mode-code-indent-offset 4)   ; JavaScript,PHP

  (setq web-mode-style-padding 4)       ; <style>
  (setq web-mode-script-padding 4)      ; <script>

  (setq web-mode-enable-auto-pairing nil) ; 自動タグ閉じ
  (setq web-mode-enable-css-colorization nil) ; RGBをバックグラウンドに反映

  (setq indent-tabs-mode t)

  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-html-attribute-value
                     ac-source-html-tag
                     ac-source-html-attribute
                     ))
          ("php" . (ac-source-php-completion
                    ac-source-words-in-same-mode-buffers
                    ac-source-filename))
          )
        )
  )
(add-hook 'web-mode-hook 'web-mode-hook)
