;; yasnippet
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

;; ;; コメントやリテラルではスニペットを展開しない
;; (setq yas/buffer-local-condition
;;       '(or (not (or (string= "font-lock-comment-face"
;;                              (get-char-property (point) 'face))
;;                     (string= "font-lock-string-face"
;;                              (get-char-property (point) 'face))))
;;            '(require-snippet-condition . force-in-comment)))

;; (yas/load-directory "~/.emacs.d/data/yasnippet") ; スニペットのディレクトリ
