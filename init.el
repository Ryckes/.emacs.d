
;; No backup files
(setq make-backup-files nil)

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

(require 'init-dep)

; After elpa
(load "personal-config")

;; Good c++ indentation
(setq c-default-style "linux"
    c-basic-offset 4)

(require 'cc-mode)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-operator-face ((t (:foreground "red4"))) t))

;; AUCTeX	
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

