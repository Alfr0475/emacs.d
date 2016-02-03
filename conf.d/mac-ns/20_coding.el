;; create face
(defface custom-face-double-byte-space '((t (:background "gray"))) nil) ; 全角スペース
(defface custom-face-tab-string '((t (:background "gray26"))) nil) ; タブ文字
(defface custom-face-eol-space '((t (:foreground "SteelBlue" :underline t))) nil) ; 行末スペース
(defvar custom-face-double-byte-space 'custom-face-double-byte-space)
(defvar custom-face-tab-string 'custom-face-tab-string)
(defvar custom-face-eol-space 'custom-face-eol-space)

;; tab/space set color
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 custom-face-tab-string append)
     ("　" 0 custom-face-double-byte-space append)
     ("[ \t]+$" 0 custom-face-eol-space append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; paren
(show-paren-mode t)                     ; 対応括弧のハイライト
(setq show-paren-style 'mixed)          ; 括弧が画面外なら内容をハイライト

;; indent
(setq-default indent-tabs-mode nil)     ; タブを使わない
(setq-default indent-level 4)           ; インデントレベル
(setq-default tab-width 4)              ; タブ幅

;; up/down case
(put 'upcase-region 'disabled nil)      ; 大文字化の問い合わせ無し
(put 'downcase-region 'disabled nil)    ; 小文字化の問い合わせ無し

;; save place
(setq-default save-place t)             ; 各種ファイルのカーソル位置を記憶
(require 'saveplace)
(setq save-place-file "~/.emacs.d/tmp/save-place") ; カーソル位置記憶用ファイル

;; 1行ずつスクロールさせる
(setq scroll-conservatively 35
       scroll-margin 0
       scroll-step 1)

;; dirtree
(require 'dirtree)
(require 'eproject)
(defun ep-dirtree ()
  (interactive)
  (dirtree eproject-root t))
(global-set-key (kbd "C-c C-j") 'ep-dirtree)


;; オリジナルのc-styleを定義
;; 基本的にこのスタイルでコーディングする
;; 何のスタイルが適用されているか調べる時は対象の行にカーソルを置いて、C-c C-s
;; 試す場合はC-c C-oでスタイルを選んで適当に値を入れる
(c-add-style "original-style"
             '(
               (indent-level                  . 4)   ; インデントレベル
               (indent-tabs-mode              . nil) ; タブを使わない
               (tab-width                     . 4)   ; タブ幅
               (c-basic-offset                . 4)   ; c-set-offsetで特殊文字を設定した際のオフセット
               (c-toggle-electric-state       . 1)   ; 現在の行の自動インデント

               ;; 括弧前後の自動改行処理設定
               ;; 自動改行がONなら中括弧を入力した時点で自動改行される
               ;; before : 中括弧の前で自動改行
               ;; after  : 中括弧の後で自動改行
               (c-hanging-braces-alist
                . (
                   (defun-open          after)  ; 関数定義を開始する中括弧
                   (defun-close         after)  ; 関数定義を終了する中括弧
                   (class-open          after)  ; クラス定義を開始する中括弧
                   (class-close         after)  ; クラス定義を終了する中括弧
                   (inline-open         after)  ; クラス内のインラインメソッドを開始する中括弧
                   (inline-close        after)  ; クラス内のインラインメソッドを終了する中括弧
                   (block-open          after)  ; 文ブロックを開始する中括弧
                   (block-close         after)  ; 文ブロックを終了する中括弧
                   (statement-case-open after)  ; 中括弧で始まるcaseブロックの最初の行
                   (substatement-open   after)  ; substatementのブロックを開始する中括弧
                   ))

               ;; コロン前後の自動改行処理設定
               ;; 自動改行がONならコロンを入力した時点で自動改行される
               ;; before : コロンの前で自動改行
               ;; after  : コロンの後で自動改行
               (c-hanging-colons-alist
                . (
                   (case-label after)   ; caseまたはdefaultラベル
                   (label      after)   ; 通常のラベル
                   ))

               ;; 挿入された余計な空白文字のキャンセル条件設定
               ;; if-elseやセミコロン前等の余計な空白削除
               ;; { や } を打った時に再配置する
               (c-cleanup-list
                . (
                   brace-catch-brace    ; '} catch () {'の構造全体を１行に再配置する
                   brace-else-brace     ; '} else {'の構造全体を１行に再配置する
                   brace-elseif-brace   ; '} elseif () {'の構造全体を１行に配置する
                   empty-defun-braces   ; 空の関数定義の中括弧を同じ行に再配置する
                   ))

               ;; オフセット量の設定
               (c-offsets-alist
                . (
                   (defun-open            . 0) ; 関数定義を開始する中括弧
                   (defun-close           . 0) ; 関数定義を終了する中括弧
                   (defun-block-intro     . +) ; トップレベルの関数定義の最初の行
                   (class-open            . 0) ; クラス定義を開始する中括弧
                   (class-close           . 0) ; クラス定義を終了する中括弧
                   (inline-open           . 0) ; クラス内のインラインメソッドを開始する中括弧
                   (inline-close          . 0) ; クラス内のインラインメソッドを終了する中括弧
                   (topmost-intro         . 0) ; 最上位の言語構成要素の最初の行
                   (topmost-intro-cont    . 0) ; 最上位の言語構成要素の２行目以降
                   (block-open            . 0) ; 文ブロックを開始する中括弧
                   (block-close           . 0) ; 文ブロックを終了する中括弧
                   (statement             . 0) ; 通常の文
                   (statement-cont        . +) ; 分の継続行
                   (statement-block-intro . +) ; 新規文ブロックの最初の行
                   (statement-case-intro  . +) ; caseブロックの最初の行
                   (statement-case-open   . 0) ; 中括弧で始まるcaseブロックの最初の行
                   (substatement          . +) ; if,while,for,do,elseの直後の最初の行
                   (substatement-open     . 0) ; substatementのブロックを開始する中括弧
                   (case-label            . +) ; caseまたはdefaultラベル
                   (label                 . 0) ; 通常のラベル
                   (do-while-closure      . 0) ; do-while文のwhile
                   (else-clause           . 0) ; if-else文のelse
                   (comment-intro         . 0) ; コメントの導入部分だけを含んだ行
                   (arglist-intro         . +) ; 引数リストの最初の行
                   (arglist-cont          . 0) ; 引数リストを開始する括弧の行に引数がない場合、引数リストの２行目以降
                   (arglist-cont-nonempty . +) ; 引数リストを開始する括弧の行に少なくとも１つの引数がある場合、引数リストの２行目以降
                   (arglist-close         . 0) ; 引数リストを終了する括弧
                   (inclass               . +) ; クラス定義の内側に入れ子になった言語構成要素
                ))))

;;------------------------------------------------------------------------------
;; auto-complete
;;------------------------------------------------------------------------------
(require 'auto-complete-config)
;; (require 'auto-complete-yasnippet)
(require 'pos-tip)

(setq ac-comphist-file "~/.emacs.d/tmp/ac-comphist.dat")

(add-to-list 'ac-dictionary-directories "~/.emacs.d/data/auto-complete/dict")

(ac-config-default)

;; (setq ac-auto-start 1)                ; 補完を開始する文字数
(setq ac-auto-show-menu 0.2)          ; 補完リストが表示されるまでの時間

;; 補完メニュー表示キー
(ac-set-trigger-key "TAB")

;; 補完メニュー操作
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; 補完リスト設定追加
(defun ac-php-mode-setup ()
  (setq ac-sources (append '(ac-source-yasnippet) ac-sources)))
(add-hook 'php-mode-hook 'ac-php-mode-setup)

;;------------------------------------------------------------------------------
;; ace
;;------------------------------------------------------------------------------
(global-ace-isearch-mode 1)             ; 常にace-isearchを有効にする
(define-key isearch-mode-map (kbd "M-o") 'helm-multi-swoop-all-from-isearch)

;;------------------------------------------------------------------------------
;; diff
;;------------------------------------------------------------------------------
(defun diff-mode-setup ()
  (diff-auto-refine-mode t)           ; 変更箇所の文字単位で色を付ける

  (set-face-foreground 'diff-added             "#90EE90") ; diff 追加分文字
  (set-face-foreground 'diff-changed           "#FFFF00") ; diff 追加分文字
  (set-face-foreground 'diff-indicator-added   "#90EE90") ; diff 追加分文字
  (set-face-foreground 'diff-indicator-changed "#FFFF00") ; diff 追加分文字
  (set-face-foreground 'diff-indicator-removed "#8B0000") ; diff 追加分文字
  (set-face-foreground 'diff-refine-change     "#000000") ; diff 文字単位での変更箇所文字
  (set-face-background 'diff-refine-change     "#FFFF00") ; diff 文字単位での変更箇所背景
  (set-face-foreground 'diff-removed           "#8B0000") ; diff 削除分文字
  )
(add-hook 'diff-mode-hook 'diff-mode-setup)

;;------------------------------------------------------------------------------
;; anzu
;;------------------------------------------------------------------------------
(require 'anzu)
(global-anzu-mode +1)

;;------------------------------------------------------------------------------
;; auto-highlight-symbol
;;------------------------------------------------------------------------------
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode)

;;------------------------------------------------------------------------------
;; flycheck
;;------------------------------------------------------------------------------
;; (require 'flycheck)

;; (setq flycheck-check-syntax-automatically '(mode-enabled save idle-change))
;; (setq flycheck-idle-change-delay 2)

;; (add-hook 'after-init-hook #'global-flycheck-mode)

;;------------------------------------------------------------------------------
;; git-gutter-fringe+
;;------------------------------------------------------------------------------
(require 'git-gutter-fringe)
(global-git-gutter-mode 1)

;;------------------------------------------------------------------------------
;; rainbow-delimiters
;;------------------------------------------------------------------------------
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode) ; 括弧の対応を虹色にする

;; rainbow-delimitersの色を強調する
;; http://d.hatena.ne.jp/murase_syuka/20140815/1408061850
(require 'cl-lib)
(require 'color)
(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
   (cl-callf color-saturate-name (face-foreground face) 30)))

;;------------------------------------------------------------------------------
;; yasnippet
;;------------------------------------------------------------------------------
(require 'yasnippet)

(custom-set-variables
 '(yas/trigger-key "TAB")               ; 単語展開キーバインド
 '(yas/snippet-dirs '("~/.emacs.d/data/yasnippet"))) ; スニペットの保存先

(yas/global-mode 1)

;; helm interface
(eval-after-load "helm-config"
  '(progn
     (defun my-yas/prompt (prompt choices &optional display-fn)
       (let* ((names (loop for choice in choices
                           collect (or (and display-fn (funcall display-fn choice))
                                       choice)))
              (selected (helm-other-buffer
                         `(((name . ,(format "%s" prompt))
                            (candidates . names)
                            (action . (("Insert snippet" . (lambda (arg) arg))))))
                         "*helm yas/prompt*")))
         (if selected
             (let ((n (position selected names :test 'equal)))
               (nth n choices))
           (signal 'quit "user quit!"))))
     (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
     (define-key helm-command-map (kbd "y") 'yas/insert-snippet)))

(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))

;; keybind
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet) ; 既存スニペットの挿入
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)    ; 新規スニペットの作成
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file) ; 既存スニペットの閲覧と編集

;;------------------------------------------------------------------------------
;; align
;;------------------------------------------------------------------------------
(require 'align)

;; Align for php-mode
;; http://d.hatena.ne.jp/Tetsujin/20070614/1181757931
(add-to-list 'align-rules-list
             '(php-assignment
               (regexp   . "[^-=!^&*+<>/.| \t\n]\\(\\s-*[.-=!^&*+<>/|]*\\)=>?\\(\\s-*\\)\\([^= \t\n]\\|$\\)")
               (justify  . t)
               (tab-stop . nil)
               (modes    . '(php-mode))))
(add-to-list 'align-dq-string-modes 'php-mode)
(add-to-list 'align-sq-string-modes 'php-mode)
(add-to-list 'align-open-comment-modes 'php-mode)
(setq align-region-separate (concat "\\(^\\s-*$\\)\\|"
                                    "\\([({}\\(/\*\\)]$\\)\\|"
                                    "\\(^\\s-*[)}\\(\*/\\)][,;]?$\\)\\|"
                                    "\\(^\\s-*\\(}\\|for\\|while\\|if\\|else\\|"
                                    "switch\\|case\\|break\\|continue\\|do\\)[ ;]\\)"
                                    ))
