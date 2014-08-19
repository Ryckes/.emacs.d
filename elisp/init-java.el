;; Improve font-lock (highlighting) in java-mode
(make-face 'font-lock-operator-face)
(make-face 'font-lock-end-statement)
(setq font-lock-operator-face 'font-lock-operator-face)
(setq font-lock-end-statement 'font-lock-end-statement)
(font-lock-add-keywords 'java-mode '(
;; Currently support for []|&!.+=-/%*,()<>{}
("\\(\\[\\|\\]\\|[|!\\.\\+\\=\\&\\<\\>]\\|-\\|\\/\\|\\%\\|\\*\\|,\\|(\\|)\\|>\\|<\\|{\\|}\\)" 1 font-lock-operator-face )
("\\(;\\)" 1 font-lock-end-statement) ))

(provide 'init-java)
