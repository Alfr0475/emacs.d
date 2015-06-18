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
(setq save-place-file "~/.emacs.d/save-place") ; カーソル位置記憶用ファイル

;; 1行ずつスクロールさせる
(setq scroll-conservatively 35
       scroll-margin 0
       scroll-step 1)

;; linum-mode
(require 'hlinum)
(global-linum-mode t)                   ; バッファ中の行番号表示
(setq linum-format "%5d")               ; 行番号書式

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

(custom-set-variables
 '(undo-tree-auto-save-history t)
 '(undo-tree-history-directory-alist '(("". "~/.emacs.d/undo-tree")))
 '(undo-tree-visualizer-timestamps t)
 )
(define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-quit)
(define-key undo-tree-visualizer-mode-map (kbd "RET") 'undo-tree-visualizer-quit)

;; rainbow-delimiters
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

;; git-gutter-fringe+
(require 'git-gutter-fringe+)
(global-git-gutter+-mode 1)


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

