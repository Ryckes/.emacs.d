
(add-to-list 'file-coding-system-alist '("\\.js" . utf-8-unix) )
(add-to-list 'file-coding-system-alist '("\\.css" . utf-8-unix) )
(add-to-list 'file-coding-system-alist '("\\.html" . utf-8-unix) )
(add-to-list 'file-coding-system-alist '("\\.htm" . utf-8-unix) )
(add-to-list 'file-coding-system-alist '("\\.php" . utf-8-unix) )
(add-to-list 'file-coding-system-alist '("\\.el" . utf-8-unix) )
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(setq-default buffer-file-coding-system 'utf-8-unix)

(provide 'init-encoding)