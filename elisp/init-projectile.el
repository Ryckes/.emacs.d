
(package-install-if-missing "projectile")

(projectile-global-mode)
(setq projectile-enable-caching t)

(global-set-key (kbd "C-x p") 'projectile-find-file)
(global-set-key (kbd "C-x j") 'projectile-switch-project)

(provide 'init-projectile)