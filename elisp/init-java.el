;; Improve font-lock (highlighting) in java-mode
(make-face 'font-lock-operator-face)
(make-face 'font-lock-end-statement)
(setq font-lock-operator-face 'font-lock-operator-face)
(setq font-lock-end-statement 'font-lock-end-statement)
(font-lock-add-keywords 'java-mode '(
;; Currently support for []|&!.+=-/%*,()<>{}
("\\(\\[\\|\\]\\|[|!\\.\\+\\=\\&\\<\\>]\\|-\\|\\/\\|\\%\\|\\*\\|,\\|(\\|)\\|>\\|<\\|{\\|}\\)" 1 font-lock-operator-face )
("\\(;\\)" 1 font-lock-end-statement) ))

(require 'compile)
(add-hook 'java-mode-hook
	  (lambda ()
	    (set (make-local-variable 'compile-command)
		 (let ((file (file-name-nondirectory buffer-file-name)))
		   (format "javac %s"
			   file)))))
(define-key java-mode-map (kbd "C-c C-c") 'compile)
(define-key java-mode-map (kbd "C-c C-r") 'recompile)

(provide 'init-java)
