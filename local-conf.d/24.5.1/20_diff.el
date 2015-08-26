;; diff
(defun diff-mode-setup ()
  (diff-auto-refine-mode t)           ; 変更箇所の文字単位で色を付ける

  (set-face-foreground 'diff-added             "#90EE90") ; diff 追加分文字
  (set-face-foreground 'diff-changed           "#FFFF00") ; diff 追加分文字
  (set-face-foreground 'diff-indicator-added   "#90EE90") ; diff 追加分文字
  (set-face-foreground 'diff-indicator-changed "#FFFF00") ; diff 追加分文字
  (set-face-foreground 'diff-indicator-removed "#8B0000") ; diff 追加分文字
  (set-face-foreground 'diff-refine-change     "#000000") ; diff 文字単位での変更箇所文字
  (set-face-background 'diff-refine-change     "#FFFF00") ; diff 文字単位での変更箇所背景
  (set-face-foreground 'diff-removed           "#8B0000") ; diff 削除分文字
  )
(add-hook 'diff-mode-hook 'diff-mode-setup)
