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
