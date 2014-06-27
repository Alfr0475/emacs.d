(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(setq popwin:popup-window-position 'bottom) ; ポップアップの位置を画面下に表示
(setq helm-samewindow nil)                  ; helmのポップアップウィンドウ対応


;; ポップアップバッファ一覧
(setq popwin:special-display-config '(
                                      (" *auto-async-byte-compile*" :height 14 :noselect t)
                                      ("helm" :regexp t :height 0.4)
                                      ("*Google Translate*" :noselect t)
                                      ("*Warnings*" :noselect t)
                                      ("*Compile-Log*" :noselect t)
                                      ("*magit-process*" :noselect t)
                                      ("*magit-diff*" :height 0.4)
                                      ("*Kill Ring*" :height 0.4)
                                      ("*grep*" :height 0.4)
                                      ("*Help*" :noselect t)
))
