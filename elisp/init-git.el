(unless (string< emacs-version "24")
  (package-install-if-missing "magit")
  ;; Magit bindings
  (global-set-key (kbd "C-x g") 'magit-status))

(provide 'init-git)
