(package-install-if-missing "web-mode")
(package-install-if-missing "phpunit")
(require 'web-mode)
(require 'scss-mode)

;; web-mode for HTML, CSS, and PHP files
(add-to-list 'auto-mode-alist '("\\.php" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.html" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig" . web-mode))
;; Disabled
;;(add-to-list 'auto-mode-alist '("\\.js" . web-mode))

(setq scss-compile-at-save nil)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'auto-complete-mode)

(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-indent-style 4)

(setq web-mode-tag-auto-close-style 2) ; Auto close tags

;; Customizing syntax highlighting
(setq kev-html-color "dodger blue") ; kev- is for namespacing
(set-face-attribute 'web-mode-html-tag-face nil :foreground kev-html-color)
(set-face-attribute 'web-mode-html-attr-name-face nil :foreground kev-html-color)
(set-face-attribute 'web-mode-html-attr-value-face nil :foreground "orchid")
(set-face-attribute 'web-mode-preprocessor-face nil :foreground "DeepSkyBlue4") ; php opening and closing tags
(set-face-attribute 'web-mode-string-face nil :foreground "magenta4") ; php strings
(set-face-attribute 'web-mode-keyword-face nil :foreground "dark cyan") ; php keywords

(define-key web-mode-map (kbd "RET") 'newline-and-indent)
(define-key web-mode-map (kbd "}") '(lambda (char)
				      (interactive "p")
				      (self-insert-command char)
				      (indent-for-tab-command)
				      ))
(define-key web-mode-map (kbd "C-x t a") 'phpunit-current-project) ; a for all
(define-key web-mode-map (kbd "C-x t c") 'phpunit-current-class) ; c for class
(define-key web-mode-map (kbd "C-x t t") 'phpunit-current-test) ; t for test

(provide 'init-web)
