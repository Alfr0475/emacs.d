;; mode-line
(setq display-time-string-forms
      '(year "/" month "/" day " "
             dayname " " 24-hours ":" minutes))
(display-time)                          ; 時刻表示

(line-number-mode t)                    ; カーソル行表示
(column-number-mode t)                  ; カーソル列表示
(blink-cursor-mode 0)                   ; カーソル点滅表示
(setq next-screen-context-lines 1)      ; 画面スクロール時の重複行数
