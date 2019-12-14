;;; system --- base system configuration

;;; Commentary:
;;; Sets up the base Emacs system configuration.

;;; Code:

;;; General
(require 'dired-x)
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(winner-mode t)
(transient-mark-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(add-to-list 'default-frame-alist
	     '(font . "Triplicate T4c-16"))
(text-scale-set 0)
(global-auto-revert-mode t)


(setq create-lockfiles nil)

(setq ring-bell-function 'ignore)

(save-place-mode t)
(setq save-place-file (concat user-emacs-directory "places"))

(setq flyspell-issue-message-flag nil)

(setq sentence-end-double-space nil)

;;; Backup
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t
      backup-by-copying t
      version-control t
      delete-old-versions t
      delete-by-moving-to-trash t
      kept-old-versions 6
      kept-new-versions 9
      auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200)

;;; Text
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;;; Key bindings
(global-set-key (kbd "M-o") 'other-window)

;;; system.el ends here
