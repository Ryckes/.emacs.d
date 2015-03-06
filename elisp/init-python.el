
(require 'python)


(require 'compile)
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (let ((file (file-name-nondirectory buffer-file-name)))
                   (format "python %s"
                           file)))))

(define-key python-mode-map (kbd "C-c C-c") 'compile)
(define-key python-mode-map (kbd "C-c C-r") 'recompile)

(provide 'init-python)
