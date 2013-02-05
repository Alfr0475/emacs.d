(require 'csharp-mode)

(add-hook 'csharp-mode-hook
          '(lambda()
             (c-set-style "original-style")
             ;;(font-lock-add-magic-number) ; 数値の色を変更する

             ;; csharp-insert-open-braceを無効に
             ;; 中括弧を入力した時点で勝手に指定スタイルで括弧を書かれるのが嫌だ
             (local-unset-key (kbd "{"))
             ))
