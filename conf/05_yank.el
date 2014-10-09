(require 'browse-kill-ring)
(global-set-key "\M-y" 'browse-kill-ring)
(setq browse-kill-ring-display-style 'one-line) ; kill-ring を一行で表示
(setq browse-kill-ring-quit-action 'kill-and-delete-window) ; browse-kill-ring 終了時にバッファを kill する
(setq browse-kill-ring-resize-window t) ; 必要に応じて browse-kill-ring のウィンドウの大きさを変更する
(setq browse-kill-ring-separator "-------") ; kill-ring の内容を表示する際の区切りを指定する
(setq browse-kill-ring-highlight-current-entry t) ; 現在選択中の kill-ring のハイライトする
(setq browse-kill-ring-separator-face 'region) ; 区切り文字のフェイスを指定する
(setq browse-kill-ring-maximum-display-length 100) ; 一覧で表示する文字数を指定する。 nil ならすべて表示される。

;; MacOSとクリップボードを共有する
(cond ((and run-darwin)
       (defun copy-from-osx ()
         (shell-command-to-string "pbpaste"))

       (defun paste-to-osx (text &optional push)
         (let ((process-connection-type nil))
           (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
             (process-send-string proc text)
             (process-send-eof proc))))

       (setq interprogram-cut-function 'paste-to-osx)
       (setq interprogram-paste-function 'copy-from-osx)
))
