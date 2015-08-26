(require 'flycheck)

(setq flycheck-check-syntax-automatically '(mode-enabled save idle-change))
(setq flycheck-idle-change-delay 2)

(add-hook 'after-init-hook #'global-flycheck-mode)
