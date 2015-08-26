(require 'csharp-mode)
(require 'omnisharp)

(setq omnisharp-server-executable-path "/Users/skoga/work/sources/github/github.com/nosami/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp.exe")

(add-hook 'csharp-mode-hook
          '(lambda()
             (c-set-style "original-style")
             ;;(font-lock-add-magic-number) ; 数値の色を変更する

             ;; csharp-insert-open-braceを無効に
             ;; 中括弧を入力した時点で勝手に指定スタイルで括弧を書かれるのが嫌だ
             (local-unset-key (kbd "{"))

             (flycheck-mode 1)
             (omnisharp-mode)
             (auto-complete-mode)
             ))

(define-key omnisharp-mode-map "\C-c\C-s" 'omnisharp-start-omnisharp-server)
(define-key omnisharp-mode-map "\M-/" 'omnisharp-auto-complete)
(define-key omnisharp-mode-map "." 'omnisharp-add-dot-and-auto-complete)
(define-key omnisharp-mode-map "\C-c\C-c" 'omnisharp-build-in-emacs)
(define-key omnisharp-mode-map "\C-c\C-N" 'omnisharp-navigate-to-solution-member)
(define-key omnisharp-mode-map "\C-c\C-n" 'omnisharp-navigate-to-current-file-member)
(define-key omnisharp-mode-map "\C-c\C-f" 'omnisharp-navigate-to-solution-file)
(define-key omnisharp-mode-map "\C-c\C-g" 'omnisharp-go-to-definition)
(define-key omnisharp-mode-map "\C-c\C-r" 'omnisharp-rename)
(define-key omnisharp-mode-map "\C-c\C-v" 'omnisharp-run-code-action-refactoring)
(define-key omnisharp-mode-map "\C-c\C-o" 'omnisharp-auto-complete-overrides)
(define-key omnisharp-mode-map "\C-c\C-u" 'omnisharp-helm-find-symbols)
(define-key omnisharp-mode-map "\C-c\C-t\C-s" (lambda() (interactive) (omnisharp-unit-test "single")))
(define-key omnisharp-mode-map "\C-c\C-t\C-r" (lambda() (interactive) (omnisharp-unit-test "fixture")))
(define-key omnisharp-mode-map "\C-c\C-t\C-e" (lambda() (interactive) (omnisharp-unit-test "all")))
