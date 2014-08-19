(defvar dependency-directory 
  (expand-file-name "dep" user-emacs-directory)
  "Directory where all non-elpa dependencies are installed.")
(setq package-already-refreshed nil)

(add-to-list 'load-path dependency-directory)

(defun dependency-dir (name)
  (format "%s/%s" dependency-directory name))

(defun dependency-file-name (name)
  (format "%s.el" name))

(defun dependency-full-path (name)
  (expand-file-name (dependency-file-name name) (dependency-dir name)))

(defun download-dependency (dep url)
  (interactive)
  (let ((dir (dependency-dir dep)))
    (message "%s" dir)
    (unless (file-directory-p dir)
      (make-directory dir))
    (url-copy-file url (dependency-full-path dep) t nil)))

(defun package-install-if-missing (package)
  (unless (locate-library package)
    (unless package-already-refreshed
      (setq package-already-refreshed t)
      (package-refresh-contents))
    (package-install (intern package))))
;; I use intern because locate-library's argument is a string
;; and package-install's argument is a symbol's name
 

(unless (>= emacs-major-version 24)
  (add-to-list 'load-path (expand-file-name "package" dependency-directory))
  (unless (locate-library "package")
    (download-dependency "package" "http://bit.ly/pkg-el23")))

(require 'package)
;; Add MELPA repo
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(provide 'init-dep)
