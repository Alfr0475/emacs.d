(require 'csharp-mode)

(add-hook 'csharp-mode-hook
          '(lambda()
             (c-set-style "original-style")
             (font-lock-add-magic-number) ; 数値の色を変更する
             ))
