(global-ace-isearch-mode 1)             ; 常にace-isearchを有効にする

(define-key isearch-mode-map (kbd "M-o") 'helm-multi-swoop-all-from-isearch)
