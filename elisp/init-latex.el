
;; AUCTeX	
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'reftex-mode)
(setq reftex-plug-into-AUCTeX t)

(provide 'init-latex)
