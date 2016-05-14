
(when (>= emacs-major-version 24)
  (package-install-if-missing "projectile")

  (projectile-global-mode)
  (setq projectile-enable-caching t)
  (add-to-list 'projectile-globally-ignored-directories
               "node_modules")

  ;; No keybindings, using Helm alternatives
  (global-set-key (kbd "C-x p") 'projectile-find-file)
  (global-set-key (kbd "C-x j") 'projectile-switch-project))

(provide 'init-projectile)