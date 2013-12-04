;;(require 'magit)

(cond ((and window-system run-emacs24 run-w32)
       (setq magit-git-executable "C:/Program Files/Git/bin/git.exe")
       )
      ((and run-linux)
       (setq magit-git-executable "/usr/bin/git")
       )
      )
