;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(def-package! aggressive-indent
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

(def-package! super-save
  :config
  (progn
    (super-save-mode +1)))

(def-package! markdown-mode
  :init
  (setq markdown-hide-urls t))

(after! elisp-mode
  (setq initial-major-mode 'emacs-lisp-mode))

(setq flycheck-disabled-checkers '(go-megacheck))

(load! "+ui")
(load! "+bindings")
(load! "+org")
(load! "+mail")

(provide 'config)
