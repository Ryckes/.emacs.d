
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c r") 'org-capture)

(package-install-if-missing "org-alert")
(require 'org-alert)
(org-alert-enable)

(setq org-agenda-span 3
      org-agenda-show-log t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-start-on-weekday 1 ; Start on Monday
      org-agenda-window-setup 'current-window

      org-agenda-files
      '("~/org/organizer.org" "~/org/business.org" "~/org/notes.org")
      
      org-refile-targets '((org-agenda-files :tag . "PROJECT") ("organizer.org" :level . 1))

      org-todo-keywords
      '((sequence
         "TODO(t)"
         "STARTED(s)"
         "MAYBE(m)"
         "WAITING(w)"
         "|"
         "DONE(d!)"))

      org-todo-keyword-faces
      '(("TODO" . (:foreground "tan1" :weight bold))
        ("STARTED" . (:foreground "yellow" :weight bold))
        ("MAYBE" . (:foreground "firebrick" :weight bold))
        ("WAITING" . (:foreground "gray" :weight bold))
        ("DONE" . (:foreground "cyan" :weight bold)))

      org-tags-exclude-from-inheritance
      '("PROJECT" "NOLIST")
      
      org-stuck-projects
      '("+PROJECT/-MAYBE-DONE" ("TODO" "STARTED") nil "\\<IGNORE\\>")
      
      org-capture-templates ; %? is cursor, %i is text in active region
      '(("t" "Task" entry (file+headline "~/org/organizer.org" "Inbox")
         "* TODO %?\n %i\n")
        ("p" "Project" entry (file "~/org/organizer.org")
         "* %? :PROJECT:\n %i\n")
        ("l" "Learn about" entry (file+headline "~/org/organizer.org" "Learn about")
         "* %?\n %i\n")
        ("i" "Idea" entry (file+headline "~/org/organizer.org" "Ideas")
         "* %? :IDEA:\n %i\n")
        ("h" "Habit" entry (file "~/org/organizer.org")
         "* TODO %?\n %i\n SCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\") nil nil nil nil \" .+1d\")\n :PROPERTIES:\n :STYLE: habit\n :END:\n")
        ("n" "Note" entry (file "~/org/notes.org")
         "* %? :NOTE:\n %i\n")
        ("k" "My web" entry (file "~/server/personal/TODO.org")
         "* %?\n %i\n")
        ("w" "Work" entry (file "~/org/business.org")
         "* TODO %? :WORK:\n %i\n"))
      
      org-agenda-custom-commands
      '(("a" "Agenda"
         ((org-agenda-list nil nil 1)
          (tags "PROJECT/-WAITING-DONE-MAYBE")
          (tags-todo "/WAITING")
          (tags-todo "-SCHEDULED={.+}/-WAITING-MAYBE")
          (stuck)))
        ;; (org-habit-graph-column)))
        ;; ("b" tags-todo "/MAYBE")
        ("p" "Projects" tags "PROJECT/-MAYBE-DONE" nil)
        ;; ("M" tags "PROJECT/MAYBE" nil)
        ("n" "Notes" tags "NOTE" nil)
        ("k" "My web" todo ""
         ((org-agenda-files '("~/server/personal/TODO.org"))))
        ("l" "To learn" tags "CHECKUP-NOLIST" nil)
        ("i" "Ideas" tags "IDEA" nil)
        ("L" "Need to be online" tags-todo "ONLINE" nil)
        ("P" "Need to be on the phone" tags-todo "@PHONE" nil)
        ("O" "Need to use the computer" tags-todo "@COMPUTER" nil)
        ("H" "Need to be at home" tags-todo "@HOME" nil)
        ("C" "Need to be in college" tags-todo "@COLLEGE" nil)
        ("w" "Work" tags "WORK" nil))

      org-enforce-todo-dependencies t

      org-columns-default-format
      "#+COLUMNS: %40ITEM(Task) %TODO %1PRORITY %13TAGS %17Effort %CLOCKSUM"

      org-pretty-entities t

      org-use-speed-commands t
      org-speed-commands-user '(("o" . delete-other-windows)
                                ("r" . org-capture)
                                ("1" . (lambda () (interactive) (org-todo "TODO")))
                                ("2" . (lambda () (interactive) (org-todo "STARTED")))
                                ("3" . (lambda () (interactive) (org-todo "MAYBE")))
                                ("4" . (lambda () (interactive) (org-todo "WAITING")))
                                ("5" . (lambda () (interactive) (org-todo "DONE"))))

      alert-default-style 'libnotify)

(defun ryckes/export-org-tasks ()
  "Export of personal files in plain text"
  (interactive)
  (org-tags-view nil "CHECKUP-NOLIST")
  (write-file "~/Dropbox/org/LEARN")
  (org-agenda-quit)
  (org-tags-view nil "@COLLEGE/-DONE")
  (write-file "~/Dropbox/org/COLLEGE")
  (org-agenda-quit)
  (org-tags-view nil "@COMPUTER/-DONE")
  (write-file "~/Dropbox/org/COMPUTER")
  (org-agenda-quit)
  (org-tags-view nil "ONLINE/-DONE")
  (write-file "~/Dropbox/org/ONLINE")
  (org-agenda-quit)
  (org-tags-view nil "@PHONE/-DONE")
  (write-file "~/Dropbox/org/PHONE")
  (org-agenda-quit)
  (org-tags-view nil "/TODO")
  (write-file "~/Dropbox/org/TODO")
  (org-agenda-quit)
  (org-tags-view nil "/WAITING")
  (write-file "~/Dropbox/org/WAITING")
  (org-agenda-quit)
  (org-agenda nil "a")
  (delete-other-windows))

(defun ryckes/org-agenda-schedule-today ()
  "Schedule a task in the agenda for today."
  (interactive)
  (org-agenda-schedule nil "+0d"))

(defun ryckes/org-agenda-schedule-tomorrow ()
  "Schedule a task in the agenda for tomorrow."
  (interactive)
  (org-agenda-schedule nil "+1d"))

(defun ryckes/org-add-tag (tag)
  "Add tag TAG to the list of tags of the current task"
  (interactive "MNew tag: ")
  (setq tags (org-get-tags-at))
  (push tag tags)
  (org-set-tags-to (delete-dups tags)))

(defun ryckes/org-agenda-add-tag (tag)
  "Add tag TAG to the list of tags of the current task"
  (interactive "MNew tag: ")
  (setq agenda-buffer (current-buffer))
  (org-agenda-switch-to)
  (ryckes/org-add-tag tag)
  (switch-to-buffer agenda-buffer)
  (org-agenda-redo))

(setq org-icalendar-include-todo '(all))
(setq org-icalendar-use-scheduled '(event-if-todo event-if-not-todo))
(setq org-icalendar-use-deadline '(event-if-todo event-if-not-todo))

(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "1" (lambda () (interactive) (org-agenda-todo "TODO")))
            (define-key org-agenda-mode-map "2" (lambda () (interactive) (org-agenda-todo "STARTED")))
            (define-key org-agenda-mode-map "3" (lambda () (interactive) (org-agenda-todo "MAYBE")))
            (define-key org-agenda-mode-map "4" (lambda () (interactive) (org-agenda-todo "WAITING")))
            (define-key org-agenda-mode-map "5" (lambda () (interactive) (org-agenda-todo "DONE")))
            (define-key org-agenda-mode-map (kbd "C-t C-t") 'ryckes/org-agenda-add-tag)
            (define-key org-agenda-mode-map (kbd "C-t t") 'ryckes/org-agenda-add-tag)
            (define-key org-agenda-mode-map (kbd "C-t l") (lambda () (interactive) (ryckes/org-agenda-add-tag "ONLINE")))
            (define-key org-agenda-mode-map (kbd "C-t p") (lambda () (interactive) (ryckes/org-agenda-add-tag "@PHONE")))
            (define-key org-agenda-mode-map (kbd "C-t o") (lambda () (interactive) (ryckes/org-agenda-add-tag "@COMPUTER")))
            (define-key org-agenda-mode-map (kbd "C-t h") (lambda () (interactive) (ryckes/org-agenda-add-tag "@HOME")))
            (define-key org-agenda-mode-map (kbd "C-t c") (lambda () (interactive) (ryckes/org-agenda-add-tag "@COLLEGE")))
            (define-key org-agenda-mode-map (kbd "P") 'ryckes/export-org-tasks)
            (define-key org-agenda-mode-map (kbd "W t") 'ryckes/org-agenda-schedule-today)
            (define-key org-agenda-mode-map (kbd "W o") 'ryckes/org-agenda-schedule-tomorrow)))

(add-hook 'org-mode-hook
          (lambda ()
            (setq org-habit-graph-column 80)
            (setq truncate-lines nil)
            (global-unset-key (kbd "C-t"))
            (define-key org-mode-map (kbd "C-'") 'help-command)
            (define-key org-mode-map (kbd "C-t C-t") 'ryckes/org-add-tag)
            (define-key org-mode-map (kbd "C-t t") 'ryckes/org-add-tag)
            (define-key org-mode-map (kbd "C-t l") (lambda () (interactive) (ryckes/org-add-tag "ONLINE")))
            (define-key org-mode-map (kbd "C-t p") (lambda () (interactive) (ryckes/org-add-tag "@PHONE")))
            (define-key org-mode-map (kbd "C-t o") (lambda () (interactive) (ryckes/org-add-tag "@COMPUTER")))
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

(defun sacha-chua/org-review-month (start-date)
  "Review the month's clocked tasks and time."
  (interactive (list (org-read-date)))
  ;; Set to the beginning of the month
  (let ((org-agenda-show-log t)
        (org-agenda-start-with-log-mode t)
        (org-agenda-start-with-clockreport-mode t)
        (org-agenda-clockreport-parameter-plist '(:link t :maxlevel 3)))
    (org-agenda-list nil start-date 'month)))


(provide 'init-org)
