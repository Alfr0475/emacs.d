;;------------------------------------------------------------------------------
;; auto-insert
;;------------------------------------------------------------------------------
(auto-insert-mode t)

;; テンプレートディレクトリ指定
(setq auto-insert-directory "~/.emacs.d/data/auto-insert/")

;; テンプレートリスト
(setq auto-insert-alist
      (append '(
                ("\\.class.php" . "php/class.php") ;; クラス
                ("\\Test.php" . "php/test.php") ;; PHPUnitテストクラス
                ("\\.php" . "php/class.php") ;; 通常スクリプト
                ("\\.pl" . "perl/script.pl") ;; 通常スクリプト
                ("\\.pm" . "perl/class.pl") ;; クラス
                ("\\.cgi" . "perl/index.pl") ;; index
                )
              auto-insert-alist))

;;------------------------------------------------------------------------------
;; navi2ch
;;------------------------------------------------------------------------------
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

(setq navi2ch-directory "~/.emacs.d/data/navi2ch") ; キャッシュファイル等の置き場

(setq navi2ch-list-stay-list-window t)  ; 3ペインモードで見る

(setq navi2ch-list-window-width 40)     ; 板一覧の横幅
(setq navi2ch-list-indent-width 2)      ; 板一覧のインデント幅
(setq navi2ch-board-window-height 15)   ; スレ一覧の高さ
(setq navi2ch-bm-subject-width 80)      ; 各スレ題名の幅
(setq navi2ch-bm-number-width 4)        ; 各スレ番号の幅

(setq navi2ch-article-message-separator-width '(window-width)) ; レス区切りの幅

(setq navi2ch-mona-enable t)            ; モナーフォント有効化
(setq navi2ch-message-save-sendlog t)   ; 書き込みログ有効化

;; (add-to-list 'navi2ch-list-navi2ch-category-alist
;;               navi2ch-message-sendlog-board)

(setq navi2ch-message-user-name "")        ; デフォルトの名前
(setq navi2ch-message-mail-address "sage") ; デフォルトのメールアドレス

(setq navi2ch-board-insert-subject-with-diff t) ; Board モードのレス数欄にレスの増加数を表示する
(setq navi2ch-board-insert-subject-with-unread t) ; Board モードのレス数欄にレスの未読数を表示する

(setq navi2ch-article-exist-message-range '(1 . 1000)) ; 既読スレは全て表示
(setq navi2ch-article-new-message-range '(1000 . 1))   ; 未読スレは全て表示

;;------------------------------------------------------------------------------
;; open-junk-file
;;------------------------------------------------------------------------------
(require 'open-junk-file)
(setq open-junk-file-format "~/.emacs.d/data/junk/%Y-%m/%d-%H%M%S.")

(define-key global-map (kbd "C-, C-,") 'open-junk-file)

;;------------------------------------------------------------------------------
;; magit
;;------------------------------------------------------------------------------
(define-key global-map (kbd "C-x m") 'magit-status)

(eval-after-load 'magit
  '(progn
     (set-face-background 'magit-item-highlight "#202020")
     (set-face-foreground 'magit-diff-add "#40FF40")
     (set-face-background 'magit-diff-add "#000000")
     (set-face-foreground 'magit-diff-del "#FF4040")
     (set-face-background 'magit-diff-del "#000000")
     (set-face-foreground 'magit-diff-file-header "#2020FF")
     (set-face-background 'magit-diff-file-header "#404040")
     (set-face-background 'magit-diff-hunk-header "#404040")
     ))
