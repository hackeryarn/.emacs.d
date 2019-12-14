;;; functions --- custom helper functions

;;; Commentary:
;;; Sets up functions that add custom features to Emacs.

;;; Code:

(defun sudo ()
  "Use TRAMP to `sudo' the current buffer."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))

;;; functions.el ends here
