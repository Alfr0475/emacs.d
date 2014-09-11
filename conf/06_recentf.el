;; recentf-ext
(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)   ; 最近開いたファイル
  (setq recentf-save-file "~/.emacs.d/recentf")
  (setq recentf-exclude '("~/.emacs.d/recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1)
  (require 'recentf-ext))
