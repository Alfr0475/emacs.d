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
