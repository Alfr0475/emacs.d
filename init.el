;;----------------------------------------------------------------------
;; Emacs Configuration
;;----------------------------------------------------------------------


;;----------------------------------------------------------------------
;; 実行環境判別
;; http://d.hatena.ne.jp/hito-d/20060220#1140445790
;;----------------------------------------------------------------------
;; OSを判別
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (or (equal system-type 'usg-unix-v)
          (or  (equal system-type 'berkeley-unix)
               (equal system-type 'cygwin)))))
(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-system-v
  (equal system-type 'usg-unix-v))
(defvar run-bsd
  (equal system-type 'berkeley-unix))
(defvar run-cygwin ;; cygwinもunixグループにしておく
  (equal system-type 'cygwin))
(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))
(defvar run-darwin (equal system-type 'darwin))

;; Emacsの種類とバージョンを判別
(defvar run-emacs20
  (and (equal emacs-major-version 20)
       (null (featurep 'xemacs))))
(defvar run-emacs21
  (and (equal emacs-major-version 21)
       (null (featurep 'xemacs))))
(defvar run-emacs22
  (and (equal emacs-major-version 22)
       (null (featurep 'xemacs))))
(defvar run-emacs23
  (and (equal emacs-major-version 23)
       (null (featurep 'xemacs))))
(defvar run-emacs24
  (and (equal emacs-major-version 24)
       (null (featurep 'xemacs))))
(defvar run-meadow (featurep 'meadow))
(defvar run-meadow1 (and run-meadow run-emacs20))
(defvar run-meadow2 (and run-meadow run-emacs21))
(defvar run-meadow3 (and run-meadow run-emacs22))
(defvar run-xemacs (featurep 'xemacs))
(defvar run-xemacs-no-mule
  (and run-xemacs (not (featurep 'mule))))
(defvar run-carbon-emacs (and run-darwin window-system))


;;----------------------------------------------------------------------
;; package configuration
;;----------------------------------------------------------------------
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; Emacsのバージョンによってインストール先を変える
;; http://d.hatena.ne.jp/tarao/20150221/1424518030#tips-package-directory
(let ((versioned-dir (locate-user-emacs-file (concat "packages/" emacs-version))))
  (setq el-get-dir (expand-file-name "el-get" versioned-dir)
        package-user-dir (expand-file-name "elpa" versioned-dir))

  (setq load-path
        (append
         (list
          (expand-file-name "~/.emacs.d/packages")
          (expand-file-name (concat versioned-dir "/el-get/el-get"))
          (expand-file-name versioned-dir)
          )
         load-path)))


;; El-Getがインストールされていなければダウンロードしてインストール
;; http://d.hatena.ne.jp/tarao/20150221/1424518030#el-get-setup
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; パッケージ毎に独立した設定ファイルを使う
;; http://d.hatena.ne.jp/tarao/20150221/1424518030#el-get-package-config
(setq el-get-user-package-directory
      (locate-user-emacs-file (format "package-conf.d/%s" emacs-version)))

;; El-Get install packages
(when (load (format "install-packages-%s" emacs-version) nil t))


;;----------------------------------------------------------------------
;; load-path configuration
;;----------------------------------------------------------------------
;; (setq load-path
;;       (append
;;        (list
;;         (expand-file-name "~/.emacs.d/elisp")
;;         (expand-file-name "~/.emacs.d/elisp/library")
;;         (expand-file-name "~/.emacs.d/elisp/library/emu")
;;         (expand-file-name "~/.emacs.d/elisp/mode")
;;         (expand-file-name "~/.emacs.d/elisp/mode/bat")
;;         (expand-file-name "~/.emacs.d/elisp/mode/pukiwiki")
;;         )
;;        load-path))


;;----------------------------------------------------------------------
;; load settings
;;----------------------------------------------------------------------
(require 'init-loader)
(setq init-loader-show-log-after-init 'error-only) ; ログにエラーのみを表示
(init-loader-load (locate-user-emacs-file (format "local-conf.d/%s" emacs-version)))


;;----------------------------------------------------------------------
;; start server
;;----------------------------------------------------------------------
(require 'server)

(unless (server-running-p)              ; 複数サーバー起動を防ぐ
  (server-start))


(provide 'init)
