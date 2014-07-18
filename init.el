
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore) ; Important

;; No backup files
(setq make-backup-files nil)

(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

; Get 'package' if not present and define some utilities
(require 'init-dep)

(require 'init-encoding)
(require 'init-c)
(require 'init-latex)
(require 'init-java)
(require 'init-web)
(require 'init-git)
(require 'init-utils)
(require 'init-snippets)
; Currently disabled:
; (require 'init-autocomplete)

; Dark theme
(when (>= emacs-major-version 24)
  (load-theme 'deeper-blue))
