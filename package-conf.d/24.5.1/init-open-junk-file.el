(require 'open-junk-file)
(setq open-junk-file-format "~/.emacs.d/data/junk/%Y-%m/%d-%H%M%S.")

(define-key global-map (kbd "C-, C-,") 'open-junk-file)
