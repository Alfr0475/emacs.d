;; APEL非依存版 (Emacs 24の場合)
(when (>= emacs-major-version 24)
  (elscreen-start))


;; APEL依存版 (Emacs 23と同居させたい場合)
(when (<= emacs-major-version 23)
  (add-to-load-path "elisp/library/apel")
  (require 'elscreen))


;; frame-titleにスクリーンの一覧を表示する
(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
           (screen-to-name-alist (elscreen-get-screen-to-name-alist))
           (title (mapconcat
                   (lambda (screen)
                     (format "%d%s %s"
                             screen (elscreen-status-label screen)
                             (get-alist screen screen-to-name-alist)))
                   screen-list " ")))
      (if (fboundp 'set-frame-name)
          (set-frame-name title)
        (setq frame-title-format title)))))

(eval-after-load "elscreen"
  '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))
