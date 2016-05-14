(unless (or (string< emacs-version "24")
            (and (string-equal emacs-version "24")
                 (string< emacs-minor-version "4")))
  (package-install-if-missing "magit")
  (setq magit-last-seen-setup-instructions "1.4.0")
  
  ;; Magit bindings
  (global-set-key (kbd "C-x g") 'magit-status))

(provide 'init-git)
