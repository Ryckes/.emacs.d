(package-install-if-missing "js2-mode")
(package-install-if-missing "js2-refactor")
(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json" . javascript-mode)) ;; Not exactly js, but undoubtedly related

(js2r-add-keybindings-with-prefix "C-c C-m")

(provide 'init-js)
