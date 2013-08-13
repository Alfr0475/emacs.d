;; cmigemo
(when
    (and
     (executable-find "cmigemo")
     (require 'migemo nil t))

  (setq migemo-command "cmigemo")                                     ; cmigemoを使う
  (setq migemo-options '("-q" "-e"))                   ; コマンドラインオプション
  (setq migemo-dictionary "~/.emacs.d/data/migemo/utf-8/migemo-dict") ; migemo辞書の場所
  (setq migemo-user-dictionary nil)                                   ; cmigemoで必須設定。おそらくuser単位の辞書の場所
  (setq migemo-regex-dictionary nil)                                  ; cmigemoで必須設定。おそらく正規表現辞書かな？
  (setq migemo-coding-system 'utf-8-unix)                             ; cmigemoの文字コード設定
  ;;(setq migemo-pre-conv-function 'migemo-utf8-conv)
  ;;(setq migemo-after-conv-function 'migemo-utf8-conv)
  ;;(setq migemo-after-conv-function nil)
  ;;(setq migemo-pre-conv-function nil)
  ;;(setq migemo-isearch-enable-p t)                              ; isearch-{forward,backward}へのラッパーon/off

  (migemo-init)
  )

(defun migemo-utf8-conv (word pattern)
  (message "hogehoge %s %s" word pattern)
)
