
(setq inhibit-startup-screen t)

;; No backup files
(setq make-backup-files nil)

; Remove menus and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

; Get 'package' if not present and define some utilities
(require 'init-dep)

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
