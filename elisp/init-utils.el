
;; Enable ido
(package-install-if-missing "flx-ido")
(flx-ido-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(delete-selection-mode 1)

(pdf-tools-install)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(when (or (and (= emacs-major-version 23)
	       (>= emacs-minor-version 2))
	  (>= emacs-major-version 24))
  (global-subword-mode 1) ; CamelCase wise word navigation
  )


(global-set-key (kbd "C-o") (lambda ()
                              (interactive)
                              (open-line 1)
                              (save-excursion
                                (next-line)
                                (indent-according-to-mode))))

;; Thanks to http://www.emacswiki.org/emacs/CamelCase
(defun split-name (s)
  (split-string
   (let ((case-fold-search nil))
     (downcase
      (replace-regexp-in-string "\\([a-z]\\)\\([A-Z]\\)" "\\1 \\2" s)))
   "[^A-Za-z0-9]+"))

(defun mapcar-head (fn-head fn-rest list)
  (if list
      (cons (funcall fn-head (car list)) (mapcar fn-rest (cdr list)))))
  
(defun camelize-from-dashes (s) ; to camelCase
  (mapconcat 'identity
             (mapcar-head
              'downcase
              'capitalize
              (split-name s)) ""))


(unless (>= emacs-major-version 24)
  (defun split-window-right ()
    (interactive)
    (split-window-horizontally)
    ))

;; Open main configuration files
(defun load-conf-files ()
  (interactive)
  (delete-other-windows)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c c") 'load-conf-files)

;; Reload config files
(defun reload-config ()
  (interactive)
  (load-file "~/.emacs.d/init.el")
  )

(global-set-key (kbd "C-c i") 'reload-config)

(defun toggle-ui (val)
  (interactive)
  (menu-bar-mode val)
  (tool-bar-mode val)
  (scroll-bar-mode val))
(defun show-ui ()
  (interactive)
  (toggle-ui 1))
(defun hide-ui ()
  (interactive)
  (toggle-ui -1))

(global-set-key (kbd "<f5>") 'show-ui)
(global-set-key (kbd "<f6>") 'hide-ui)

(hide-ui) ; Please

;; Holy sudo-edit
(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current buffer is not visiting a file."
  (interactive "p")
  (let ((which-function-on (assq 'which-function-mode minor-mode-alist))
        (projectile-mode-on (assq 'projectile-mode minor-mode-alist)))
    (message which-function-on)
    (which-function-mode 0)
    (projectile-global-mode 0)
    (if (or arg (not buffer-file-name))
        (find-file (concat "/sudo:root@localhost:"
                           (replace-regexp-in-string "/sudo:root@localhost:" "" (read-file-name "Find file (as root): "))))
      (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name)))
    (if which-function-on (which-function-mode 1))
    (if projectile-mode-on (projectile-global-mode 1))))

(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (if (get-buffer new-name)
        (message "A buffer named '%s' already exists!" new-name)
      (progn
        (when (file-exists-p filename)
          (rename-file filename new-name t))
        (rename-buffer new-name)
        (set-visited-file-name new-name)))))

(global-unset-key (kbd "C-x C-r"))
(global-set-key (kbd "C-x C-r") 'sudo-edit)

;; Some key bindings
(global-set-key (kbd "C-x w") 'whitespace-mode)
(global-set-key (kbd "C-c b") '(lambda () (interactive)
				 (eval-buffer)
				 (message "Buffer eval'd."))) ; Need feedback
(global-set-key (kbd "C-c e") 'eval-expression)
(global-set-key (kbd "C-<kp-add>") 'text-scale-increase)
(global-set-key (kbd "C-<kp-subtract>") 'text-scale-decrease)

(global-set-key (kbd "C-x y") 'eshell)

(global-set-key (kbd "C-x !") (lambda ()
                                "Eval shell command and insert its output at point."
                                (interactive)
                                (let ((current-prefix-arg 4)) ; emulate C-u
                                  (call-interactively 'shell-command))))
(global-set-key (kbd "C-c !") (lambda ()
                                "Eval shell command, feed it with region contents and insert its output at point."
                                (interactive)
                                (shell-command-on-region (region-beginning) (region-end) (read-shell-command "Shell command on region: ") t))) ; Dump to current buffer

(global-set-key (kbd "M-p") 'previous-error)
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-o") 'occur)
(define-key isearch-mode-map (kbd "M-o") 'isearch-occur)

(define-key occur-mode-map (kbd "p") 'previous-line)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "f") 'next-error-follow-minor-mode)

;; Eval and replace (for in-buffer things)
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
	     (current-buffer))
    (error (message "Invalid expression")
	   (insert (current-kill 0)))))

(global-set-key (kbd "C-c g") 'eval-and-replace)


;; Remove annoying message "this buffer still has clients" when killing a buffer
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-functions)

;; Set browser to google-chrome
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Hungry delete mode
(package-install-if-missing "hungry-delete")
(require 'hungry-delete)
(global-hungry-delete-mode)

(provide 'init-utils)
