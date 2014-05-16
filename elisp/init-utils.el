
(unless (>= emacs-major-version 24)  
  (defun split-window-right ()
    (interactive)
    (split-window-horizontally)
    ))

; Open main configuration files
(defun load-conf-files ()
  (interactive)
  (delete-other-windows)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c c") 'load-conf-files)


; Reload config files
(defun reload-config ()
  (interactive)
  (load-file "~/.emacs.d/init.el")
)

(global-set-key (kbd "C-c i") 'reload-config);


; Holy sudo-edit
(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current buffer is not visiting a file."
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
			 (read-file-name "Find file (as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(global-unset-key (kbd "C-x C-r"))
(global-set-key (kbd "C-x C-r") 'sudo-edit)


; Some key bindings
(global-set-key (kbd "C-c C-e") 'query-replace)
(global-set-key (kbd "C-c C-f") 'query-replace-regexp)
(global-set-key (kbd "C-c b") '(lambda () (interactive)
				 (eval-buffer)
				 (message "Buffer eval'd.") ; Need feedback
				 ))
(global-set-key (kbd "C-c e") 'eval-expression)


; Eval and replace (for in-buffer things)
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
	     (current-buffer))
    (error (message "Invalid expression")
	   (insert (current-kill 0)))))

(global-set-key (kbd "C-c r") 'eval-and-replace)



(provide 'init-utils)
