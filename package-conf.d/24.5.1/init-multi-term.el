(require 'multi-term)
(setq multi-term-program shell-file-name)

(add-to-list 'term-unbind-key-list '"M-x")

(add-hook 'term-mode-hook
          '(lambda ()
             ;; C-h を term 内文字削除にする
             (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
             ;; C-y を term 内ペーストにする
             (define-key term-raw-map (kbd "C-y") 'term-paste)
             ;; C-p を term 内での十字キー上と同じにする
             (define-key term-raw-map (kbd "C-p") 'term-send-up)
             ;; C-n を term 内での十字キー下と同じにする
             (define-key term-raw-map (kbd "C-n") 'term-send-down)
             ;; C-v を term 内でのPageDOWNと同じにする
             (define-key term-raw-map (kbd "C-v") 'term-send-next)
             ;; M-v を term 内でのPageUPと同じにする
             (define-key term-raw-map (kbd "M-v") 'term-send-prior)
             ))
