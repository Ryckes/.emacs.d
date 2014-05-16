
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)
(define-key ac-complete-mode-map (kbd "RET") 'ac-expand)
(ac-set-trigger-key "<tab>")

(provide 'init-autocomplete)
