(package-install-if-missing "web-mode")
(require 'web-mode)

; web-mode for HTML, CSS, JS and PHP files
(add-to-list 'auto-mode-alist '("\\.php" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html" . web-mode))
; Disabled
;(add-to-list 'auto-mode-alist '("\\.js" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.css" . web-mode))

; Customizing syntax highlighting
(setq kev-html-color "red4") ; kev- is for namespacing
(set-face-attribute 'web-mode-html-tag-face nil :foreground kev-html-color)
(set-face-attribute 'web-mode-html-attr-name-face nil :foreground kev-html-color)
(set-face-attribute 'web-mode-html-attr-value-face nil :foreground "OrangeRed3")
(set-face-attribute 'web-mode-preprocessor-face nil :foreground "DeepSkyBlue4") ; php opening and closing tags
(set-face-attribute 'web-mode-string-face nil :foreground "magenta4") ; php strings
(set-face-attribute 'web-mode-keyword-face nil :foreground "dark cyan") ; php keywords

(define-key web-mode-map (kbd "RET") 'newline-and-indent)

(provide 'init-web)
