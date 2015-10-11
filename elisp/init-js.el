(package-install-if-missing "js2-mode")
(package-install-if-missing "js2-refactor")
(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json" . javascript-mode)) ;; Not exactly js, but undoubtedly related

(setq js2-include-node-externs t)

(js2r-add-keybindings-with-prefix "C-c C-m")

(define-key js2-mode-map (kbd "C-c C-r") 'recompile)
(define-key js2-mode-map (kbd "C-c C-c") 'compile)

(require 'compile)
(add-hook 'js2-mode-hook
          (lambda ()
            ;; Enable js2-refactor
            (js2-refactor-mode)

            ;; Set up compile command
            (set (make-local-variable 'compile-command)
                 (let ((file (file-name-nondirectory buffer-file-name)))
                   (format "%s %s"
                           "node"
                           file)))))

(provide 'init-js)
