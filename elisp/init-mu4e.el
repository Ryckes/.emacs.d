;; Required to use mu4e
(add-to-list 'load-path (expand-file-name "mu4e" user-emacs-directory))
(require 'mu4e)

(setq mu4e-maildir "~/offlineimap/")

(setq mu4e-html2text-command "w3m -dump -cols 120 -T text/html"
      mu4e-view-prefer-html t
      mu4e-view-show-addresses t
      mu4e-view-show-images t
      mu4e-attachment-dir "~/Downloads")

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

(global-set-key (kbd "C-x m") 'mu4e)

(require 'smtpmail)

(defun strip-last-two-dirs (path)
  (file-name-directory (directory-file-name (file-name-directory (directory-file-name path)))))

(defun ryckes/mu4e-msg-account (msg)
  (let ((maildir (file-name-directory
		  (mu4e-message-field msg :maildir))))
    (string-match "/\\(.*?\\)/" maildir)
    (match-string 1 maildir)))

(defun ryckes/mu4e-get-account-folder (account folderkey)
  (let ((account-folders (cdr (assoc account mu4e-account-folders))))
    (if account-folders
	(let ((folder (cadr (assoc folderkey account-folders))))
	  (if folder
	      folder
	    (error "Folder %s not found in %s folders" folderkey account)))
      (error "Account %s not found" account))))


;; Variables that do not change between accounts
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg")
      starttls-use-gnutls t
      mu4e-headers-skip-duplicates t
      mu4e-headers-fields '((:human-date . 12) (:flags . 6) (:from . 22) (:to . 18) (:subject))
      mu4e-refile-folder (lambda (msg)
			   (ryckes/mu4e-get-account-folder
			    (ryckes/mu4e-msg-account msg) :refile))
      mu4e-trash-folder (lambda (msg)
			  (ryckes/mu4e-get-account-folder
			   (ryckes/mu4e-msg-account msg) :trash)
			  )
      mu4e-sent-folder (lambda (msg)
			 (ryckes/mu4e-get-account-folder
			  (ryckes/mu4e-msg-account msg) :sent))
      mu4e-drafts-folder (lambda (msg)
			   (ryckes/mu4e-get-account-folder
			    (ryckes/mu4e-msg-account msg) :drafts))
      mu4e-headers-show-threads nil)

    
(defun mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (ryckes/mu4e-msg-account mu4e-compose-parent-message)
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) mu4e-account-alist)
                             nil t nil nil (caar mu4e-account-alist))))
	 (sentfolder (ryckes/mu4e-get-account-folder account :sent))
	 (draftsfolder (ryckes/mu4e-get-account-folder account :drafts))
         (account-vars (cdr (assoc account mu4e-account-alist))))
    (if account-vars
        (progn (mapc #'(lambda (var)
			 (set (car var) (cadr var)))
		     account-vars)
	       ;; Drafts and sent folder must be set before composing a message
	       (setq mu4e-sent-folder sentfolder)
	       (setq mu4e-drafts-folder draftsfolder))
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'mu4e-set-account)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)
(provide 'init-mu4e)