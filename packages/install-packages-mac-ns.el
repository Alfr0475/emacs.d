(el-get-bundle init-loader)

;; library
(el-get-bundle apel)
(el-get-bundle dash)                    ; リストAPI
(el-get-bundle f)                       ; ファイル・ディレクトリAPI
(el-get-bundle s)                       ; 文字列API
(el-get-bundle ht)                      ; ハッシュテーブルAPI
(el-get-bundle pcache)
(el-get-bundle logito)
(el-get-bundle gh)                      ; GitHubクライアントライブラリ

;; system
(el-get-bundle prodigy)                 ; Emacsでプロセスを管理する
(el-get-bundle use-package :depends (diminish)) ; Emacs設定用のマクロ
(el-get-bundle exec-path-from-shell)    ; 環境変数のpathを引き継ぐ
;;(el-get-bundle auto-async-byte-compile) ; 自動バイトコンパイル
(el-get-bundle pcre2el)
(el-get-bundle jwiegley/emacs-async)

;; helm
(el-get-bundle helm :branch "v2.5.4")
(el-get-bundle helm-ag)
(el-get-bundle helm-dired-recent-dirs)
(el-get-bundle helm-gtags)
(el-get-bundle helm-open-github)
(el-get-bundle helm-projectile)
(el-get-bundle helm-swoop)
(el-get-bundle helm-ghq)
(el-get-bundle helm-helm-commands)
(el-get-bundle helm-descbinds)
(el-get-bundle helm-git-grep)
(el-get-bundle alfr0475/helm-open-junk-file)

;; major mode
(el-get-bundle actionscript-mode)
(el-get-bundle apache-mode)
(el-get-bundle cmake-mode)
;;;;;;(el-get-bundle cmd-mode)
(el-get-bundle coffee-mode)
(el-get-bundle cperl-mode)
(el-get-bundle crontab-mode)
(el-get-bundle josteink/csharp-mode)
;;(el-get-bundle css-mode)
(el-get-bundle csv-mode)
(el-get-bundle elpa:gitignore-mode)
(el-get-bundle rafl/git-commit-mode)
(el-get-bundle gitconfig-mode)
(el-get-bundle go-mode)
(el-get-bundle gradle-mode)
(el-get-bundle js2-mode)
(el-get-bundle json-mode)
(el-get-bundle markdown-mode)
(el-get-bundle mmm-mode)
(el-get-bundle nginx-mode)
;(el-get-bundle ejmr/php-mode :branch "v1.13.5")
(el-get-bundle ejmr/php-mode)
(el-get-bundle arnested/php-extras)
(el-get-bundle ruby-mode)
;; (el-get-bundle smarty-mode)
(el-get-bundle ssass-mode)
(el-get-bundle elpa:ssh-config-mode)
(el-get-bundle swift-mode)
(el-get-bundle terraform-mode)
(el-get-bundle textile-mode)
;;;;;;(el-get-bundle tsv-mode)
(el-get-bundle twittering-mode)
;;;;;;(el-get-bundle visual-basic-mode)
(el-get-bundle vue-mode)
(el-get-bundle vue-html-mode)
(el-get-bundle web-mode)
(el-get-bundle yaml-mode)
(el-get-bundle zencoding-mode)

;; coding support
(el-get-bundle ace-jump-mode)           ; 画面内の単語に飛ぶ
(el-get-bundle ace-isearch)             ; ace-jump-mode + isearch + helm-swoop
(el-get-bundle ag)
;;;;;;(el-get-bundle align)
(el-get-bundle anzu)                    ; 検索のマッチ数表示
(el-get-bundle auto-highlight-symbol)   ; カーソルが乗っているシンボルをハイライト
(el-get-bundle avy)
(el-get-bundle browse-kill-ring)        ; kill-ringの内容を一覧表示
(el-get-bundle drag-stuff)              ; 行/Region/単語などをドラッグできるように
(el-get-bundle edit-indirect)
(el-get-bundle fringe-helper)
(el-get-bundle git-gutter)
(el-get-bundle git-gutter-fringe)       ; fringeにgit情報を表示
(el-get-bundle git-gutter-fringe+)      ; fringeにgit情報を表示
(el-get-bundle elpa:hlinum)             ; linum-modeに現在行を強調表示
(el-get-bundle elpa:htmlize)            ; ソースコードをHTMLとして出力する
(el-get-bundle idle-highlight-mode)     ; カーソルが乗っているシンボルをハイライト
;;;;;;(el-get-bundle java-complete)
(el-get-bundle json-reformat)           ; JSON整形
(el-get-bundle json-snatcher)
(el-get-bundle migemo)                  ; migemoのEmacs版
(el-get-bundle multiple-cursors)        ; 複数カーソル
(el-get-bundle pcre2el)                 ; Emacsの正規表現をPCREへ変換
;;(el-get-bundle popup)                   ; ポップアップメニューを出す
(el-get-bundle pos-tip)                 ; tipsを表示させる事ができる
;;;;;;(el-get-bundle popup-pos-tip)
(el-get-bundle popwin)                  ; 指定したバッファをポップアップウィンドウ化
(el-get-bundle projectile)              ; プロジェクト管理
(el-get-bundle rainbow-delimiters)      ; 括弧に段階を付けて色付け
(el-get-bundle rainbow-mode)            ; #FFFFFF等に色を付ける
(el-get-bundle recentf-ext)             ; recentfでディレクトリも扱う
(el-get-bundle rsense)                  ; Rubyの開発援助ツール
(el-get-bundle ruby-block)              ; Rubyのendに対応する行をハイライトする
(el-get-bundle session)                 ; Emacs起動時に前回の状態を記憶しておく
(el-get-bundle smartparens)             ; 括弧自動挿入や選択範囲を括弧で囲む
(el-get-bundle smex)                    ; M-xを曖昧マッチ
(el-get-bundle tabbar)                  ; タブエディタ化
(el-get-bundle undo-tree)               ; undoをバージョン管理する
(el-get-bundle undohist)                ; undoの永続化
(el-get-bundle wgrep)                   ; grepの結果で直接編集できる
(el-get-bundle which-key)               ; 次のキープレフィックスを教えてくれる
;;;;;;(el-get-bundle whitespace)              ; タブや行末空白の可視化
(el-get-bundle yasnippet)               ; スニペット管理

;; company-mode
(el-get-bundle company-mode)
(el-get-bundle company-quickhelp)
(el-get-bundle company-web)
;;(el-get-bundle ac-php)

;; flycheck
(el-get-bundle flycheck)           ; シンタックスチェック
(el-get-bundle flycheck-pos-tip)

;; org-mode
(el-get-bundle org-mode)

;; magit
(el-get-bundle magit)
(el-get-bundle magit-gitflow)

;; application
(el-get-bundle navi2ch)                 ; 2chブラウザ
;;(el-get-bundle OmniSharp/omnisharp-emacs)
(el-get-bundle open-junk-file)
(el-get-bundle atykhonov/google-translate :branch "v0.11.10")
(el-get-bundle multi-term)

;; joke
(el-get-bundle nyan-mode)               ; 猫がバッファのどのあたりに居るか教えてくれる


(provide 'el-get-install-packages-mac-ns)
