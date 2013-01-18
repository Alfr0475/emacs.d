;;; php-completion-opt.el --- php-completion optional utilities

;; Copyright (C) 2009  kitokitoki

;; Author: kitokitoki <morihenotegami@gmail.com>
;; Keywords: convenience
;; Prefix: phpcmpopt-

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Change Log
;; 1.0.2: phpcmpopt-manual-vertical-pop-up (垂直分割) を追加。
;;        pop-out 時に phpcmpopt-popup-document-buffer を削除するように変更。
;;        不具合修正。リファクタリング。
;; 1.0.1: cleanup で persistent-action で用いたバッファを削除する処理を追加。
;; 1.0.0: 新規作成

;; TODO documentation

;;; Code:

(require 'php-completion)

(defvar phpcmpopt-persistent-document-buffer "*phpcmp persistent doc*")
(defvar phpcmpopt-popup-document-buffer "*php-manual*")
(defvar phpcmpopt-horizontal-or-vertical-flag t
  "t なら垂直分割、nil なら水平分割")
(defvar phpcmpopt-delete-pop-up-buffer-flag t
  "t なら pop-out 時に pop-up バッファを削除、nil ならそのまま残す")
(defvar phpcmpopt-manual-window-height 75)
(setq phpcmpopt-window-size
      (round (* (window-height) (/ (- 100 phpcmpopt-manual-window-height) 100.0))))

(defun phpcmpopt-popup-document-persistent-action (candidate)
    (let ((docstring (phpcmp-get-document-string candidate))
           (b (get-buffer-create phpcmpopt-persistent-document-buffer)))
      (with-current-buffer b
        (erase-buffer)
        (insert docstring)
        (goto-char (point-min)))
      (pop-to-buffer b)))

(defun phpcmpopt-make-completion-sources ()
  (labels ((make-source (&key name candidates)
            `((name . ,name)
              (init . (lambda ()
                        (with-current-buffer (anything-candidate-buffer 'global)
                          (insert (mapconcat 'identity
                                             (if (functionp ',candidates)
                                                 (funcall ',candidates)
                                               ',candidates)
                                             "\n")))))
              (candidates-in-buffer)
              (action . (("Insert" . (lambda (candidate)
                                       (delete-backward-char (length phpcmp-initial-input))
                                       (insert candidate)))
              ("Search". (lambda (candidate)
                           (phpcmp-search-manual candidate)))))
              (persistent-action . phpcmpopt-popup-document-persistent-action)
              (cleanup . phpcmpopt-delete-persistent-action-buffer))))
    (loop for (name candidates) in (phpcmp-completions-table)
          collect (make-source
                   :name name
                   :candidates candidates))))

(defun phpcmpopt-delete-persistent-action-buffer ()
   (and (get-buffer phpcmpopt-persistent-document-buffer)
        (kill-buffer (get-buffer phpcmpopt-persistent-document-buffer))))

(defun phpcmpopt-complete ()
  (interactive)
  (anything (phpcmpopt-make-completion-sources)
            (phpcmp-get-initial-input)))

;; below is an arrange of shell-pop.el.
;; shell-pop.el is written by Kazuo YAGI
;; http://www.emacswiki.org/emacs/shell-pop.el

(defun phpcmpopt-manual-pop ()
  (interactive)
  (if (equal (buffer-name) phpcmpopt-popup-document-buffer)
      (phpcmpopt-manual-pop-out)
    (if phpcmpopt-horizontal-or-vertical-flag
        (phpcmpopt-manual-vertical-pop-up)
      (phpcmpopt-manual-horizontal-pop-up))))

(defun phpcmpopt-manual-horizontal-pop-up ()
  (setq phpcmpopt-manual-last-buffer (buffer-name))
  (setq phpcmpopt-manual-last-window (selected-window))
  (split-window (selected-window) phpcmpopt-window-size nil)
  (phpcmpopt-popup-document-at-point))

(defun phpcmpopt-manual-vertical-pop-up ()
  (setq phpcmpopt-manual-last-buffer (buffer-name))
  (setq phpcmpopt-manual-last-window (selected-window))
  (split-window (selected-window) nil t)
  (phpcmpopt-popup-document-at-point))

(defun phpcmpopt-manual-pop-out ()
  (delete-window)
  (if (and phpcmpopt-delete-pop-up-buffer-flag
           (get-buffer phpcmpopt-popup-document-buffer))
      (kill-buffer phpcmpopt-popup-document-buffer))
  (select-window phpcmpopt-manual-last-window)
  (switch-to-buffer phpcmpopt-manual-last-buffer))

(defun phpcmpopt-popup-document-at-point ()
  (interactive)
  (let* ((s (or (thing-at-point 'symbol) ""))
         (docstring (phpcmp-get-document-string s)))
    (let ((b (get-buffer-create phpcmpopt-popup-document-buffer)))
      (with-current-buffer b
        (erase-buffer)
        (insert docstring)
        (goto-char (point-min)))
      (pop-to-buffer b))))

(provide 'php-completion-opt)

;;; php-completion-opt.el ends here
