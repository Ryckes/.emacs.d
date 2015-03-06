(package-install-if-missing "cl-lib")
(package-install-if-missing "yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(setq mode-require-final-newline nil)
(setq yas-triggers-in-field t)
(defun add-yasnippet-dir (dir)
  "Add DIR to the list of directories of YASnippet snippets."
  (setq yas-snippet-dirs (append yas-snippet-dirs 
				 (cons dir '()))))
(add-yasnippet-dir (expand-file-name "snippets" user-emacs-directory))

(provide 'init-snippets)
