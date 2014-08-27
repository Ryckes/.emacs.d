
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
	 "* %? :PROJECT:\n %i\n")
	("w" "Work" entry (file "~/org/business.org")
	 "* TODO %?\n %i\n"))
      
      org-agenda-custom-commands
      '(("a" "My custom agenda"
	 ((org-agenda-list nil nil 1)
	  (tags "PROJECT/-WAITING-DONE")
	  (tags-todo "/WAITING")
	  (tags-todo "-MAYBE-SCHEDULED={.+}-DEADLINE={.+}/-WAITING")
	  (stuck)))
	("p" tags "PROJECT-MAYBE-DONE" nil)
	("m" tags "PROJECT&MAYBE" nil)))

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
	    (define-key org-agenda-mode-map "1" (lambda () (interactive) (org-agenda-todo "TODO")))
	    (define-key org-agenda-mode-map "2" (lambda () (interactive) (org-agenda-todo "STARTED")))
	    (define-key org-agenda-mode-map "3" (lambda () (interactive) (org-agenda-todo "MAYBE")))
	    (define-key org-agenda-mode-map "4" (lambda () (interactive) (org-agenda-todo "WAITING")))
	    (define-key org-agenda-mode-map "5" (lambda () (interactive) (org-agenda-todo "DONE")))
	    (define-key org-agenda-mode-map (kbd "K t") 'ryckes/org-agenda-schedule-today)
	    (define-key org-agenda-mode-map (kbd "K o") 'ryckes/org-agenda-schedule-tomorrow)))

(defun ryckes/org-add-tag (tag)
  "Add tag TAG to the list of tags of the current task"
  (interactive "MNew tag: ")
  (setq tags (org-get-tags-at))
  (push tag tags)
  (org-set-tags-to (delete-dups tags)))

(add-hook 'org-mode-hook
	  (lambda ()
	    (setq truncate-lines nil)
	    (global-unset-key (kbd "C-t"))
	    (define-key org-mode-map (kbd "C-t h") (lambda () (interactive) (ryckes/org-add-tag "@HOME")))
	    (define-key org-mode-map (kbd "C-t c") (lambda () (interactive) (ryckes/org-add-tag "@COLLEGE")))))

;; Thanks to Sacha Chua (sachachua.com)
(eval-after-load 'org
  '(progn
     (defun wicked/org-clock-in-if-starting ()
       "Clock in when the task is marked STARTED."
       (when (and (string= org-state "STARTED")
		  (not (string= org-last-state org-state)))
	 (org-clock-in)))
     (add-hook 'org-after-todo-state-change-hook
	       'wicked/org-clock-in-if-starting)
     (defun wicked/org-clock-out-if-waiting ()
       "Clock out when the task is marked WAITING."
       (when (and (string= org-state "WAITING")
		  (equal (marker-buffer org-clock-marker) (current-buffer))
		  (< (point) org-clock-marker)
		  (> (save-excursion (outline-next-heading) (point))
		     org-clock-marker)
		  (not (string= org-last-state org-state)))
	 (org-clock-out)))
     (add-hook 'org-after-todo-state-change-hook
	       'wicked/org-clock-out-if-waiting)))

(provide 'init-org)