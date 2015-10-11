(require 'cc-mode)

;; Good c++ indentation
(setq c-default-style "linux"
      c-basic-offset 4)

;; Indent macros to the same level of the code
(add-to-list 'c-offsets-alist '(cpp-macro . 0))
(add-to-list 'c-offsets-alist '(comment-intro . 0))

(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(define-key c-mode-base-map (kbd "C-c C-c") 'compile)
(define-key c-mode-base-map (kbd "C-c C-r") 'recompile)

(define-key c-mode-base-map (kbd "C-d") 'c-hungry-delete-forward)
(define-key c-mode-base-map (kbd "DEL") 'c-hungry-delete-backwards)

;; From EmacsWiki, modified
(require 'compile)
(add-hook 'c++-mode-hook
	  (lambda ()
	    (unless (file-exists-p "Makefile")
	      (set (make-local-variable 'compile-command)
               ;; $(CC) -o $@ $(CPPFLAGS) $(CFLAGS) $<
               (let ((file (file-name-nondirectory buffer-file-name)))
                 (format "%s -o %s %s %s %s && ./%s"
                         (or (getenv "CC") "g++")
                         (file-name-sans-extension file)
                         (or (getenv "CPPFLAGS") "-std=c++0x")
                         (or (getenv "CFLAGS") "-Wall -g")
                         file
                         (file-name-sans-extension file)))))))
(add-hook 'c-mode-hook
	  (lambda ()
	    (unless (file-exists-p "Makefile")
	      (set (make-local-variable 'compile-command)
		   ;; emulate make's .c.o implicit pattern rule, but with
		   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
		   ;; variables:
		   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
		   (let ((file (file-name-nondirectory buffer-file-name)))
		     (format "%s -c -o %s.o %s %s %s"
			     (or (getenv "CC") "gcc")
			     (file-name-sans-extension file)
			     (or (getenv "CPPFLAGS") "-DDEBUG=9")
			     (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g")
			     file))))))

(provide 'init-c)
