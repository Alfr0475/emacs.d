;;----------------------------------------------------------------------
;; Emacs Configuration
;;----------------------------------------------------------------------
;; Author           : $Author: koga $
;; Created On       : 2010-05-13 17:13:00
;; Last Modified On : $Date: 2011-05-26 18:37:58 +0900 (木, 26 5 2011) $
;; Revision         : $Rev: 17 $
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
(cond ((and run-emacs24)
       (require 'cask)
       (cask-initialize)
       (require 'pallet)
 ))


;;----------------------------------------------------------------------
;; load-path configuration
;;----------------------------------------------------------------------
(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d/elisp")
        (expand-file-name "~/.emacs.d/elisp/library")
        (expand-file-name "~/.emacs.d/elisp/library/emu")
        (expand-file-name "~/.emacs.d/elisp/mode")
        (expand-file-name "~/.emacs.d/elisp/mode/bat")
        (expand-file-name "~/.emacs.d/elisp/mode/pukiwiki")
        )
       load-path))


;;----------------------------------------------------------------------
;; load settings
;;----------------------------------------------------------------------
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")


;;----------------------------------------------------------------------
;; start server
;;----------------------------------------------------------------------
(require 'server)

(unless (server-running-p)              ; 複数サーバー起動を防ぐ
  (server-start))
