;; Good c++ indentation
(setq c-default-style "linux"
    c-basic-offset 4)

(require 'cc-mode)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(provide 'init-c)
