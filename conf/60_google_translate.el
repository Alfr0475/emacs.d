(require 'google-translate)
(custom-set-variables
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja"))

(global-set-key (kbd "C-x t") 'google-translate-at-point)

;; 翻訳結果をkill-ringに保存
(defadvice google-translate-paragraph (before google-translate-paragraph-before)
  (when (equal 'google-translate-translation-face (ad-get-arg 1))
    (let ((text (ad-get-arg 0)))
      (kill-new text nil nil))))
(ad-activate 'google-translate-paragraph)

;; 翻訳先言語を一時的に入れ替える
(global-set-key (kbd "C-x T") '(lambda ()
                                 (interactive)
                                 (let (
                                       (google-translate-default-source-language "ja")
                                       (google-translate-default-target-language "en")
                                       )
                                   (google-translate-at-point))))
