
(package-install-if-missing "auto-complete")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)
;; Compatibiliy of YASnippet and auto-complete
(setq ac-source-yasnippet nil)
(define-key ac-complete-mode-map (kbd "RET") nil)
(define-key ac-menu-map (kbd "<tab>") 'ac-next)
(setq
 ac-trigger-key "TAB"
 yas-trigger-key "TAB"
 ac-auto-start nil
 ac-use-menu-map t)

(provide 'init-autocomplete)
