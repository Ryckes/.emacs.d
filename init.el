
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
