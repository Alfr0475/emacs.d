(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)

;; メモファイルの保存先
(setq org-directory "~/.emacs.d/etc/org/")

;; org-default-notes-fileのファイル名
(setq org-default-notes-file (expand-file-name "memo.org" org-directory))

;; org-rememberを使う
(org-remember-insinuate)

;; org-rememberの呼び出し
(global-set-key (kbd "C-c r") 'org-remember)

;; org-rememberのテンプレート
(setq org-remember-templates
      '(("Note" ?n "* %?\n  %i\n  %a" nil "Memo")
        ("Todo" ?t "* TODO %?\n  %i\n  %a" nil "Tasks")))

;; 画像をインライン表示
(setq org-startup-with-inline-images t)
(add-hook 'org-mode-hook 'turn-on-iimage-mode)


;; １階層下・上の見出し・項目を入力する。
(require 'org)
(defun org-insert-upheading (arg)
  "１レベル上の見出しを入力する。"
  (interactive "P")
  (org-insert-heading arg)
  (cond ((org-on-heading-p) (org-do-promote))
        ((org-at-item-p) (org-indent-item -1))))
(defun org-insert-heading-dwim (arg)
  "現在と同じレベルの見出しを入力する。
C-uをつけると１レベル上、C-u C-uをつけると１レベル下の見出しを入力する。"
  (interactive "P")
  (case arg
    (4  (org-insert-subheading nil))
    (16 (org-insert-upheading  nil))
    (t  (org-insert-heading nil))))
(define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)

;; ハイパーリンクの作成
(global-set-key (kbd "C-c l") 'org-store-link)
