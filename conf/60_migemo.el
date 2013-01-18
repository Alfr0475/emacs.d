;; cmigemo
(when
    (and
     (executable-find "cmigemo")
     (require 'migemo nil t))

  (setq migemo-command "cmigemo")                               ; cmigemoを使う
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))             ; コマンドラインオプション
  (setq migemo-dictionary "~/.emacs.d/data/migemo/migemo-dict") ; migemo辞書の場所
  (setq migemo-user-dictionary nil)                             ; cmigemoで必須設定。おそらくuser単位の辞書の場所
  (setq migemo-regex-dictionary nil)                            ; cmigemoで必須設定。おそらく正規表現辞書かな？
  (setq migemo-coding-system 'utf-8-unix)                       ; cmigemoの文字コード設定
  ;;(setq migemo-isearch-enable-p t)                              ; isearch-{forward,backward}へのラッパーon/off

  (migemo-init)
  )
