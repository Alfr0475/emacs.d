(setq load-path (cons (expand-file-name "~/.emacs.d/elisp/navi2ch/") load-path))
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
