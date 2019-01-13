;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(defadvice load-theme (before theme-dont-propagate activate)
  "Disable theme before loading new one."
  (mapc #'disable-theme custom-enabled-themes))

;; Font setup
(setq doom-font (font-spec :family "Fira Mono" :size 14)
      doom-big-font (font-spec :family "Fira Mono" :size 19))

;; Use different color theme
;; (setq doom-theme 'doom-opera-light)

;; macosx transparent titlebar
(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

(def-package! page-break-lines
  :config
  (progn
    (add-to-list 'page-break-lines-modes 'org-agenda-mode)
    (global-page-break-lines-mode t)))

(def-package! olivetti
  :init
  :config
  (progn
    (setq olivetti-hide-mode-line t)))

(defun turn-off-prose-mode ()
  (interactive)
  (set-face-attribute 'variable-pitch nil :family "Fira Mono")
  (load-theme 'doom-one t)
  (olivetti-mode 0))

(defun turn-on-prose-mode ()
  (interactive)
  (load-theme 'poet-dark-monochrome t)
  (set-face-attribute 'variable-pitch nil :family "Baskerville")
  (set-face-attribute 'default nil :family "Fira Mono" :height 140)
  (set-face-attribute 'fixed-pitch nil :family "Fira Mono")
  (display-line-numbers-mode 0)
  (vi-tilde-fringe-mode 0)
  (turn-on-olivetti-mode)
  (olivetti-set-width 100))

(setq toni/prose-mode-loaded nil)
(defun toni/load-theme ()
  (interactive)
  (when (derived-mode-p 'text-mode)
    (when (not toni/prose-mode-loaded)
      (progn
        (turn-on-prose-mode)
        (setq toni/prose-mode-loaded t))))
  (when (derived-mode-p 'prog-mode)
    (when toni/prose-mode-loaded
      (progn
        (turn-off-prose-mode)
        (setq toni/prose-mode-loaded nil)))))

(add-hook 'post-command-hook 'toni/load-theme)
(add-hook 'text-mode-hook
          (lambda ()
            (variable-pitch-mode 1)))

(provide '+ui)
