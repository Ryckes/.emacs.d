
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c r") 'org-capture)

(setq org-agenda-span 3
      org-agenda-show-log t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-start-on-weekday 1 ; Start on Monday

      org-agenda-files
      '("~/org/organizer.org" "~/org/business.org")
      
      org-todo-keywords
      '((sequence
	 "TODO(t)"
	 "STARTED(s)"
	 "MAYBE(m)"
	 "WAITING(w)"
	 "|"
	 "DONE(d)"))

      org-todo-keyword-faces
      '(("TODO" . (:foreground "tan1" :weight bold))
	("STARTED" . (:foreground "yellow" :weight bold))
	("MAYBE" . (:foreground "firebrick" :weight bold))
	("WAITING" . (:foreground "gray" :weight bold))
	("DONE" . (:foreground "cyan" :weight bold)))
      
      org-tags-exclude-from-inheritance
      '("PROJECT")
      
      org-stuck-projects
      '("+PROJECT/-MAYBE-DONE" ("TODO" "STARTED") nil "\\<IGNORE\\>")
      
      org-capture-templates ; %? is cursor, %i is text in active region
      '(("t" "Task" entry (file+headline "~/org/organizer.org" "Inbox")
	 "* TODO %?\n %i\n")
	("p" "Project" entry (file "~/org/organizer.org")
	 "* %?\n %i\n"))
      
      org-agenda-custom-commands
      '(("a" "My custom agenda"
	 ((org-agenda-list nil nil 1)
	  (tags "PROJECT-WAITING")
	  (tags-todo "WAITING")
	  (tags-todo "-MAYBE-SCHEDULED={.+}")
	  (stuck)))
	("p" tags "PROJECT-MAYBE-DONE" nil)
	("m" tags "PROJECT&MAYBE" nil)))

(defun sacha/org-agenda-mark-done-and-add-followup () ; Thanks to Sacha Chua (sachachua.com)
  "Mark the current TODO as done and add another task after it at the same level."
  (interactive)
  (org-agenda-todo "DONE")
  (org-agenda-switch-to)
  (org-capture 0 "t"))

(defun ryckes/org-agenda-schedule-today ()
  "Schedule a task in the agenda for today."
  (interactive)
  (org-agenda-schedule nil "+0d"))

(defun ryckes/org-agenda-schedule-tomorrow ()
  "Schedule a task in the agenda for tomorrow."
  (interactive)
  (org-agenda-schedule nil "+1d"))

(add-hook 'org-agenda-mode-hook
	  (lambda ()
	    (define-key org-agenda-mode-map "X" 'sacha/org-agenda-mark-done-and-add-followup)
	    (define-key org-agenda-mode-map "1" (lambda () (interactive) (org-agenda-todo "TODO")))
	    (define-key org-agenda-mode-map "2" (lambda () (interactive) (org-agenda-todo "STARTED")))
	    (define-key org-agenda-mode-map "3" (lambda () (interactive) (org-agenda-todo "MAYBE")))
	    (define-key org-agenda-mode-map "4" (lambda () (interactive) (org-agenda-todo "WAITING")))
	    (define-key org-agenda-mode-map "5" (lambda () (interactive) (org-agenda-todo "DONE")))
	    (define-key org-agenda-mode-map (kbd "K t") 'ryckes/org-agenda-schedule-today)
	    (define-key org-agenda-mode-map (kbd "K o") 'ryckes/org-agenda-schedule-tomorrow)))
  

(provide 'init-org)