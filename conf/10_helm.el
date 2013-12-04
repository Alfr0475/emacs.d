(require 'helm)
(require 'helm-config)

(helm-mode 1)                           ; 常時helm使用
;;(helm-dired-bindings 1)

(setq helm-idle-delay 0.2)        ; 候補を表示するまでの時間
(setq helm-input-idle-delay 0.1)  ; タイプしてから再描画するまでの時間
(setq helm-quick-update t)        ; 体感速度向上
(setq helm-execute-action-at-once-if-one nil) ; 候補が一つの場合になっても自動実行しない
(remove-hook 'kill-emacs-hook 'helm-c-adaptive-save-history) ; Emacs終了時に、履歴を保存


;; buffer-listにヒストリとカレントディレクトリを追加したオリジナル関数追加
(defun my:helm-buffers-list ()
  "Preconfigured `helm' to list buffers.
It is an enhanced version of `helm-for-buffers'."
  (interactive)
  (helm :sources '(helm-c-source-buffers-list
                  helm-c-source-ido-virtual-buffers
                  helm-c-source-buffer-not-found
                  helm-c-source-file-name-history
                  helm-c-source-files-in-current-dir)
        :buffer "*helm buffers*" :keymap helm-c-buffer-map))


(custom-set-variables '(helm-ff-auto-update-initial-value nil)) ; 自動補完を無効

(define-key helm-c-read-file-map (kbd "C-h") 'delete-backward-char) ; C-hでバックスペース
(define-key helm-c-read-file-map (kbd "TAB") 'helm-execute-persistent-action) ; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定する事も可能

(define-key helm-map (kbd "C-h") 'delete-backward-char) ; helm中はC-hが効かなかったから再定義

(global-set-key (kbd "C-c h") 'helm-mini)        ; helm起動
(global-set-key (kbd "C-x C-f") 'helm-for-files) ; デフォルトのhelm-find-fileを変更
(global-set-key (kbd "C-x b") 'my:helm-buffers-list) ; switch-to-bufferをhelmのlist-bufferに変更
(global-set-key (kbd "C-z b") 'helm-elscreen) ; elscreen-findをhelmに変更
(global-set-key (kbd "C-M-z") 'helm-resume) ; 直前のhelm実行結果に復帰する
(global-set-key (kbd "M-x") 'helm-M-x)      ; コマンド実行をhelmに変更
(global-set-key (kbd "M-y") 'helm-show-kill-ring) ; yankをhelm化

;; 前後のsourceに移動
(define-key helm-map (kbd "C-v") 'helm-next-source)
(define-key helm-map (kbd "M-v") 'helm-previous-source)

(define-key helm-map (kbd "C-z") nil)   ; elscreenのprefixなのでnilに

;; helm-migemo
;; helmにmigemoを使う
(require 'helm-match-plugin nil t)
(require 'helm-migemo)
(helm-migemize-command helm-c-source-files-in-current-dir)
(helm-migemize-command helm-c-source-find-files)

;; helm-grep
(require 'helm-grep)


;; (let ((completing-read-function 'completing-read-default))
;;   (completing-read prompt comp-func nil nil nil nil tagname))))

;; (eval-after-load “helm-mode”
;;   ‘(progn
;;       (add-to-list
;;        ‘helm-completing-read-handlers-alist
;;          ‘(lusty-sudo-explorer . nil))
;;       (add-to-list
;;        ‘helm-completing-read-handlers-alist
;;          ‘(lusty-file-explorer . nil))
;;       (add-to-list
;;        ‘helm-completing-read-handlers-alist
;;          ‘(lusty-buffer-explorer . nil))))
