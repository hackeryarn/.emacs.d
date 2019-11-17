;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; general

;; use-package setup

(add-to-list 'load-path "~/.emacs.d/custom")

(load "system.el")
(load "packages.el")
(load "org-config.el")

;; automatic configs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (smartparens markdown-mode restclient dumb-jump flyspell-correct-ivy projectile prettier-js vterm expand-region hungry-delete undo-tree yasnippet flycheck ace-flyspell emmet-mode web-mode go-mode typescript-mode js2-mode racket-mode cider clojure-mode paredit magit company solarized-theme ace-window org-bullets which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-car-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
