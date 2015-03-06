
(require 'compile)
(require 'octave)
(add-hook 'octave-mode-hook
          (lambda ()
            (auto-complete-mode)
            (set (make-local-variable 'compile-command)
                 (let ((file (file-name-nondirectory buffer-file-name)))
                   (format "octave %s"
                           file)))))
(define-key octave-mode-map (kbd "C-c C-c") 'compile)
(define-key octave-mode-map (kbd "C-c C-r") 'recompile)

(provide 'init-octave)
