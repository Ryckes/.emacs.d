
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore) ; Important

;; Move backup files
(setq backup-directory-alist '(("." . "~/.saves")))

(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; Dark theme
(when (>= emacs-major-version 24)
  (load-theme 'deeper-blue))

;; Get 'package' if not present and define some utilities
(require 'init-dep)

(require 'init-encoding)
(require 'init-c)
(require 'init-latex)
(require 'init-java)
(require 'init-octave)
(require 'init-web)
(require 'init-js)
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

