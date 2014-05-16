(package-install-if-missing "cl-lib")
(package-install-if-missing "yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
; Compatibiliy of YASnippet and auto-complete
(setq ac-source-yasnippet nil)
(defun add-yasnippet-dir (dir)
  "Add DIR to the list of directories of YASnippet snippets."
  (setq yas-snippet-dirs (append yas-snippet-dirs 
				 (cons dir '()))))
(add-yasnippet-dir (expand-file-name "snippets" user-emacs-directory))

(provide 'init-snippets)
