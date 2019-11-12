;; Use-package setup
(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(show-paren-mode 1)

(global-hl-line-mode 1)

;; General packages
(use-package which-key
  :ensure t
  :config
  (setq which-key-idle-delay 0.1)
  (which-key-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ace-window
  :ensure t
  :init
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
   '(aw-leading-car-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))))

(use-package solarized-theme
  :ensure t
  :init
  (load-theme 'solarized-light t))

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
    ;; enable this if you want `swiper' to use it
    ;; (setq search-default-mode #'char-fold-to-regexp)

  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

(use-package avy
  :ensure t
  :config
  (avy-setup-default)
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2))

(use-package saveplace
  :ensure t
  :config
  (progn
   (setq-default save-place t)
   (setq save-place-file (concat user-emacs-directory "places"))))

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

;; Dev packages
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; Clojure
(use-package clojure-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode)))

(use-package cider
  :ensure t)

;; Racket
(use-package racket-mode
  :ensure t)

(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook       #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)
  (add-hook 'ielm-mode-hook             #'paredit-mode)
  (add-hook 'lisp-mode-hook             #'paredit-mode)
  (add-hook 'racket-mode-hook             #'paredit-mode)
  (add-hook 'clojure-mode-hook             #'paredit-mode)
  (add-hook 'cider-repl-mode-hook #'paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
  (add-hook 'scheme-mode-hook           #'paredit-mode))

;; JavaScript
(use-package js2-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

;; Web
(use-package web-mode
  :ensure t)

(use-package emmet-mode
  :ensure t)

;; Go
(use-package go-mode
  :ensure t)
