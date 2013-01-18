;; (autoload 'svn-status "dsvn" "Run `svn status'." t)
;; (autoload 'svn-update "dsvn" "Run `svn update'." t)

(setenv "SVN_SSH" "C:/Program Files/TortoiseSVN/bin/TortoisePlink.exe -l seikikoga -pw stigma0475")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")

(setq vc-svn-program "C:/Program Files/TortoiseSVN/bin/svn.exe")

(modify-coding-system-alist 'process "svn" '(undecided . utf-8-unix))
(modify-coding-system-alist 'process "svn" '(undecided . euc-jp-unix))
(modify-coding-system-alist 'process "svn" '(undecided . euc-japan))
(modify-coding-system-alist 'process "svn" '(undecided . undecided-unix))
(modify-coding-system-alist 'process "svn" '(undecided . sjis))
(modify-coding-system-alist 'process "svn" '(undecided . iso-2022-jp))
