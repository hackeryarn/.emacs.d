;;; org-config --- configures org mode

;;; Commentary:
;;; Provide general org configurations and custom helper functions.

;; Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (clojure . t)
   (python . t)
   (scheme . t)
   (emacs-lisp . t)))
;; Refile
(advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-targets '(("~/Sync/gtd/todo.org" :level . 1)
			   ("~/Sync/gtd/work.org" :level . 1)))

;; Agenda Custom Command
(setq org-agenda-start-day "-1d")

(defun create-org-agenda-skip-entry-if (tag)
  `'(org-agenda-skip-entry-if
     'notregexp ,(concat ":" (car tag) ":")))

(defun create-task-agenda-custom-command (tag)
  (list 'todo
	"TODO"
	(list
	 (list
	  'org-agenda-skip-function
	  (create-org-agenda-skip-entry-if tag))
	 (list
	  'org-agenda-overriding-header
	  (capitalize (car tag))))))

(defun create-home-agenda-custom-command (span)
  (list
   (list 'agenda ""
	 (list
	  (list 'org-agenda-span span)
	  '(org-agenda-files '("~/Sync/gtd/todo.org"))))))

(defun create-home-task-list ()
  '((todo "TODO"
	  ((org-agenda-overriding-header "Todo")
	   (org-agenda-todo-ignore-deadlines 'all)
	   (org-agenda-todo-ignore-scheduled 'all)
	   (org-agenda-files '("~/Sync/gtd/todo.org"))))
    (todo "WAITING"
	  ((org-agenda-overriding-header "Waiting")
	   (org-agenda-todo-ignore-deadlines 'all)
	   (org-agenda-todo-ignore-scheduled 'all)
	   (org-agenda-files '("~/Sync/gtd/todo.org"))))))

(defun create-work-agenda-custom-command (span)
  (list
   (list 'agenda ""
	 (list
	  (list 'org-agenda-span span)
	  '(org-agenda-files '("~/Sync/gtd/work.org"))))))

(defun create-work-task-list ()
  '((todo "TODO"
	  ((org-agenda-overriding-header "Todo")
	   (org-agenda-todo-ignore-deadlines 'all)
	   (org-agenda-todo-ignore-scheduled 'all)
	   (org-agenda-files '("~/Sync/gtd/work.org"))))
    (todo "WAITING"
	  ((org-agenda-overriding-header "Waiting")
	   (org-agenda-todo-ignore-deadlines 'all)
	   (org-agenda-todo-ignore-scheduled 'all)
	   (org-agenda-files '("~/Sync/gtd/work.org"))))))

(defun create-daily-home-agenda-custom-command ()
  (list "h" "Home" (append (create-home-agenda-custom-command 3)
			   (create-home-task-list))))
(defun create-daily-work-agenda-custom-command ()
  (list "w" "Work" (append (create-work-agenda-custom-command 3)
			   (create-work-task-list))))

(defun create-org-agenda-custom-commands ()
  (list (create-daily-home-agenda-custom-command)
	(create-daily-work-agenda-custom-command)))

;; Agenda
(setq org-agenda-prefix-format " %b")
(setq org-agenda-files '("~/Sync/gtd/todo.org"))
(setq org-agenda-custom-commands (create-org-agenda-custom-commands))

;; Capture
(setq-default org-todo-keywords '((sequence "TODO(t)" "SCHEDULED(s)" "WAITING(w)" "TALK(z)" "|" "DONE(d)" "CANCELLED(c)")
				  (sequence "PROJECT(p)" "MAYBE(m)")))

(defun create-tag-capture (tag)
  (let ((tag (car tag)))
    (list tag (capitalize tag) 'entry
	  '(file "~/Sync/gtd/todo.org")
	  (concat "* TODO %i%? :" tag ":"))))

(defun org-template-todo ()
  '("i" "Inbox" entry
    (file "~/Sync/gtd/inbox.org")
    "* TODO %i%?"))

(defun org-template-journal ()
  '("j" "Journal" entry
    (file+olp+datetree "~/Sync/org/journal.org")
    "* %?" :tree-type week))

(defun org-template-task ()
  '("t" "Task Journal" entry
    (file+olp+datetree "~/Sync/org/task-journal.org")
    "* %U\n%i%?" :tree-type week))

(defun org-template-week ()
  '("w" "Weekly Review" entry
    (file+olp+datetree "~/Sync/org/weekly-review.org")
    "* Wins\n- %?\n* Struggles\n- \n* Ball Drops\n- " :tree-type week))

(defun org-template-month ()
  '("m" "Monthly Review" entry
    (file+olp+datetree "~/Sync/org/monthly-review.org")
    "* Wins\n- %?\n* Struggles\n- \n* Ball Drops\n- "))

(setq org-capture-templates
      (list (org-template-todo)
	    (org-template-journal)
	    (org-template-week)
	    (org-template-month)
	    (org-template-task)))

(defun org-config/open-inbox ()
  "Opens my gtd inbox file"
  (interactive)
  (find-file "~/Sync/gtd/inbox.org"))

(defun org-config/open-journal ()
  "Opens my journal file"
  (interactive)
  (find-file "~/Sync/org/journal.org"))

(defun org-config/open-task-journal ()
  "Opens my journal file"
  (interactive)
  (find-file "~/Sync/org/task-journal.org"))

(defun org-config/get-day (post)
  "Gets the day number from the post"
  (string-match "\\([[:digit:]]+\\)" post)
  (string-to-number (match-string 1 post)))

(defun org-config/next-post-name (post)
  "Creates the title for the next post with the previous post"
  (format "day%d.md"(+ 1 (org-config/get-day post))))

(defun org-config/increment-day ()
  (let (p1 p2 word)
    (search-forward "day: ")
    (setq p1 (point))
    (forward-word)
    (setq p2 (point))
    (setq word (buffer-substring-no-properties p1 p2))
    (backward-word)
    (kill-word 1)
    (insert (number-to-string (+ 1 (string-to-number word))))))

(defun org-config/update-date ()
  (search-forward "date: ")
  (kill-line)
  (insert (format-time-string "%Y-%m-%d")))

(defun org-config/update-metadata (post)
  (with-temp-buffer
    (insert-file-contents post)
    (let (p1 p2)
      (setq p1 (point))
      (search-forward "---")
      (org-config/increment-day)
      (org-config/update-date)
      (search-forward "---")
      (setq p2 (point))
      (buffer-substring-no-properties p1 p2))))

(defun org-config/new-post ()
  "Creates a new post for daily reading notes"
  (interactive)
  (let* ((old-post-name (buffer-name (current-buffer)))
         (new-post-name (org-config/next-post-name old-post-name))
         (metadata (org-config/update-metadata old-post-name)))
    (with-temp-file new-post-name
      (insert metadata))
    (find-file new-post-name)
    (kill-buffer old-post-name)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;;; org-config.el ends here
