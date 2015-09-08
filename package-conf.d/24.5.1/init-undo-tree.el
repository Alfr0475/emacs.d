(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

(custom-set-variables
 '(undo-tree-auto-save-history t)
 '(undo-tree-history-directory-alist '(("". "~/.emacs.d/tmp/undo-tree")))
 '(undo-tree-visualizer-timestamps t)
 )
(define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)
(define-key undo-tree-visualizer-mode-map (kbd "RET") 'undo-tree-visualizer-quit)
