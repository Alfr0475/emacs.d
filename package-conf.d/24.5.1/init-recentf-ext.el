(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)   ; 最近開いたファイル
  (custom-set-variables '(recentf-save-file "~/.emacs.d/tmp/recentf"))
  (setq recentf-exclude '("~/.emacs.d/tmp/recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (require 'recentf-ext))
