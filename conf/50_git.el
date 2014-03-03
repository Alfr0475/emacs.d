(cond ((and window-system run-emacs24 run-w32)
       (setq magit-git-executable "C:/Program Files (x86)/Git/bin/git.exe")
       )
      ((and run-linux)
       (setq magit-git-executable "/usr/bin/git")
       )
      )

(define-key global-map (kbd "C-x m") 'magit-status)

(eval-after-load 'magit
  '(progn
     (set-face-background 'magit-item-highlight "#202020")
     (set-face-foreground 'magit-diff-add "#40FF40")
     (set-face-background 'magit-diff-add "#000000")
     (set-face-foreground 'magit-diff-del "#FF4040")
     (set-face-background 'magit-diff-del "#000000")
     (set-face-foreground 'magit-diff-file-header "#2020FF")
     (set-face-background 'magit-diff-file-header "#404040")
     (set-face-background 'magit-diff-hunk-header "#404040")
     ))
