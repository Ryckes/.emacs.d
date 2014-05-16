
;; No backup files
(setq make-backup-files nil)

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

(require 'init-dep)

; After elpa
(load "personal-config")

(setq inhibit-startup-screen t)

(require 'init-c)
(require 'init-latex)
