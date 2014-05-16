; Remove menus and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

; Make Text mode the default mode for new buffers
(setq-default major-mode 'text-mode)

; Dark theme
(when (>= emacs-major-version 24)
  (load-theme 'deeper-blue))

(require 'init-java)
(require 'init-web)
(require 'init-git)
(require 'init-utils)
(require 'init-snippets)
; Currently disabled:
; (require 'init-autocomplete)
