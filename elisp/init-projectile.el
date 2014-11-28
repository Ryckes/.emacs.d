
(package-install-if-missing "projectile")

(projectile-global-mode)
(setq projectile-enable-caching t)

(global-set-key (kbd "C-x p") 'projectile-find-file)

(provide 'init-projectile)