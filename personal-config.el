; Remove menus and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)

; Make Text mode the default mode for new buffers
(setq-default major-mode 'text-mode)

; Dark theme
(load-theme 'deeper-blue)
; Improve font-lock (highlighting) in java-mode
(make-face 'font-lock-operator-face)
(make-face 'font-lock-end-statement)
(setq font-lock-operator-face 'font-lock-operator-face)
(setq font-lock-end-statement 'font-lock-end-statement)
(font-lock-add-keywords 'java-mode '(
; Currently support for []|&!.+=-/%*,()<>{}
("\\(\\[\\|\\]\\|[|!\\.\\+\\=\\&\\<\\>]\\|-\\|\\/\\|\\%\\|\\*\\|,\\|(\\|)\\|>\\|<\\|{\\|}\\)" 1 font-lock-operator-face )
("\\(;\\)" 1 font-lock-end-statement) ))

(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'init-web)
(require 'init-git)
(require 'init-utils)

; Enable YASnippet
(add-to-list 'load-path
	     "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)
; Compatibiliy of YASnippet and auto-complete
(setq ac-source-yasnippet nil)
(defun add-yasnippet-dir (dir)
  "Add DIR to the list of directories of YASnippet snippets."
  (setq yas-snippet-dirs (append yas-snippet-dirs 
				 (cons dir '()))))
(add-yasnippet-dir "~/.emacs.d/snippets")

; Enable auto-complete
;(add-to-list 'load-path "~/.emacs.d/auto-complete")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
;(ac-config-default)
;(define-key ac-complete-mode-map (kbd "RET") 'ac-expand)
;(ac-set-trigger-key "<tab>")
