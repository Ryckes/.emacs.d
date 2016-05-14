
(require 'compile)
(ignore-errors
  (require 'octave))

(if (featurep 'octave)
    (progn
      (add-to-list 'auto-mode-alist '("\\.m" . octave-mode))

      (add-hook 'octave-mode-hook
                (lambda ()
                  (auto-complete-mode)
                  (setq octave-block-offset 4)
                  (set (make-local-variable 'compile-command)
                       (let ((file (file-name-nondirectory buffer-file-name)))
                         (format "octave -q %s"
                                 file)))))
      (define-key octave-mode-map (kbd "C-c C-c") 'compile)
      (define-key octave-mode-map (kbd "C-c C-r") 'recompile)))

(provide 'init-octave)
