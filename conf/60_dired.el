;; dired拡張
(load "dired-x")

;; find-diredをLinux環境無しで使えるように
(autoload 'find-dired-lisp
  "find-dired-lisp" "findr" t nil)
(autoload 'find-grep-dired-lisp
  "find-dired-lisp" "findr" t nil)


;; スペースでマークする (FD like)
(define-key dired-mode-map " " 'dired-toggle-mark)
(defun dired-toggle-mark (arg)
  "Toggle the current (or next ARG) files."
  ;; S.Namba Sat Aug 10 12:20:36 1996
  (interactive "P")
  (let ((dired-marker-char
         (if (save-excursion (beginning-of-line)
                             (looking-at " "))
             dired-marker-char ?\040)))
    (dired-mark arg)
    (dired-previous-line 1)))

(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'dired-mode-hook
          '(lambda ()
             (make-local-variable 'mouse-highlight)
             (setq mouse-highlight nil)
             (local-set-key (kbd "RET") 'dired-find-alternate-file)
             (local-set-key (kbd "C-<return>") 'dired-advertised-find-file)
             ))

;; dired を使って、一気にファイルの coding system (漢字) を変換する
;; マークを付けたファイルに対してTで変換
;; ついでにディレクトリを選ぶ度にバッファが作られるのを抑制。
;; さらにマウスカーソルがあたってハイライトしないように設定。
(require 'dired-aux)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key (current-local-map) "T" 'dired-do-convert-coding-system)
            (make-local-variable 'mouse-highlight)
            (setq mouse-highlight nil)
            (local-set-key (kbd "RET") 'dired-find-alternate-file)
            (local-set-key (kbd "C-<return>") 'dired-advertised-find-file)
            ))

(defvar dired-default-file-coding-system nil
  "*Default coding system for converting file (s).")

(defvar dired-file-coding-system 'no-conversion)

(defun dired-convert-coding-system ()
  (let ((file (dired-get-filename))
        (coding-system-for-write dired-file-coding-system)
        failure)
    (condition-case err
        (with-temp-buffer
          (insert-file file)
          (write-region (point-min) (point-max) file))
      (error (setq failure err)))
    (if (not failure)
        nil
      (dired-log "convert coding system error for %s:\n%s\n" file failure)
      (dired-make-relative file))))

(defun dired-do-convert-coding-system (coding-system &optional arg)
  "Convert file (s) in specified coding system."
  (interactive
   (list (let ((default (or dired-default-file-coding-system
                            buffer-file-coding-system)))
           (read-coding-system
            (format "Coding system for converting file (s) (default, %s): "
                    default)
            default))
         current-prefix-arg))
  (check-coding-system coding-system)
  (setq dired-file-coding-system coding-system)
  (dired-map-over-marks-check
   (function dired-convert-coding-system) arg 'convert-coding-system t))


;; コピー、削除を再帰的にできるように
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)


;; 今日変更したファイルの時間に色を付ける
(defface dired-todays-face '((t (:foreground "green"))) nil)
(defvar dired-todays-face 'dired-todays-face)

(defconst month-name-alist
  '(("1"  . "Jan") ("2"  . "Feb") ("3"  . "Mar") ("4"  . "Apr")
    ("5"  . "May") ("6"  . "Jun") ("7"  . "Jul") ("8"  . "Aug")
    ("9"  . "Sep") ("10" . "Oct") ("11" . "Nov") ("12" . "Dec")))

(defun dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (let ((month-name
          (cdr (assoc (format-time-string "%b") month-name-alist))))
     (if month-name
         (format
          (format-time-string
           "\\(%Y-%m-%d\\|%b %e\\|%%s %e\\) [0-9]....") month-name)
       (format-time-string
        "\\(%Y-%m-%d\\|%b %e\\) [0-9]....")))
   arg t))

(eval-after-load "dired"
  '(font-lock-add-keywords
    'dired-mode
    (list '(dired-today-search . dired-todays-face))))


;; sorter改良版
(add-hook 'dired-load-hook
          (lambda ()
            (require 'sorter)))

(require 'ls-lisp)
(setq ls-lisp-dirs-first t)                ; ディレクトリを先に表示
(setq ls-lisp-use-localized-time-format t) ; 指定した日付フォーマットを使う
(setq ls-lisp-format-time-list (quote ("%Y-%m-%d %H:%M" "%Y-%m-%d %H:%M"))) ; dired上の時間フォーマット

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
