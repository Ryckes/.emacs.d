
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore) ; Important

;; Move backup files
(setq backup-directory-alist '(("." . "~/.saves")))

(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "mu4e" user-emacs-directory))

;; Get 'package' if not present and define some utilities
(require 'init-dep)

(require 'init-encoding)
(require 'init-c)
(require 'init-latex)
(require 'init-java)
(require 'init-web)
(require 'init-git)
(require 'init-utils)
(require 'init-snippets)
(require 'init-org)
(require 'init-mu4e)
;; Currently disabled:
;; (require 'init-autocomplete)

;; Dark theme
(when (>= emacs-major-version 24)
  (load-theme 'deeper-blue))
