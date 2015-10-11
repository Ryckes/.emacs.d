
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore) ; Important

;; Move backup files
(setq backup-directory-alist '(("." . "~/.saves")))

(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; Get 'package' if not present and define some utilities
(require 'init-dep)

;; Dark theme
(if (>= emacs-major-version 24)
  (load-theme 'deeper-blue)
  (progn
    (package-install-if-missing "solarized-theme")
    (load-theme 'solarized-dark)))

(require 'init-encoding)
(require 'init-c)
(require 'init-latex)
(require 'init-java)
(when (>= emacs-major-version 24)
  (require 'init-octave)
  (require 'init-js))
(require 'init-web)
(require 'init-python)
(require 'init-git)
(require 'init-utils)
(require 'init-snippets)
(require 'init-autocomplete)
(require 'init-org)
(require 'init-mu4e)
(require 'init-projectile)
;; (require 'init-helm)

;; Local files, not in the repository (secrets)
(require 'init-local)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
