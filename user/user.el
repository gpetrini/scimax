(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(add-to-list 'package-selected-packages 'org-plus-contrib)
(add-to-list 'package-selected-packages 'ess)
(add-to-list 'package-selected-packages 'conda)
(add-to-list 'package-selected-packages 'pyvenv)
(add-to-list 'package-selected-packages 'pythonic)
(add-to-list 'package-selected-packages 'poetry)
(add-to-list 'package-selected-packages 'flx)
(add-to-list 'package-selected-packages 'counsel)	
(add-to-list 'package-selected-packages 'company-mode)
(add-to-list 'package-selected-packages 'company-backends)
(add-to-list 'package-selected-packages 'company-statistics)
(add-to-list 'package-selected-packages 'julia-mode)
(add-to-list 'package-selected-packages 'julia-repl)
(add-to-list 'package-selected-packages 'eglot-jl)
;; (add-to-list 'package-selected-packages 'ob-julia)
;; (add-to-list 'load-path "~/scimax/ob-julia.el")
(add-to-list 'load-path "~/scimax/dynare.el")

(add-to-list 'package-selected-packages 'ox-reveal)
(add-to-list 'package-selected-packages 'citeproc-org)

(add-to-list 'package-selected-packages 'elfeed)
(add-to-list 'package-selected-packages 'elfeed-org)
(add-to-list 'package-selected-packages 'org-journal)

(add-to-list 'package-selected-packages 'spacemacs-theme)
(add-to-list 'package-selected-packages 'ergoemacs-mode)
(add-to-list 'package-selected-packages 'dashboard)
(add-to-list 'package-selected-packages 'pdf-tools)
(add-to-list 'package-selected-packages 'neotree)
(add-to-list 'package-selected-packages 'org-superstar)
(add-to-list 'package-selected-packages 'org-gcal)
(add-to-list 'package-selected-packages 'org-timeline)

;; Don't remove this:
(unless (every 'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (package-install 'use-package)
  (package-install-selected-packages))

(use-package delight :ensure t)
(use-package use-package-ensure-system-package :ensure t)

(custom-set-variables
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(font-use-system-font t)
 '(org-agenda-files (list "~/Dropbox/Emacs/Todos.org")))
(custom-set-faces
 )

(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/Dropbox/Emacs/elfeed.org")))

(defun gps/elfeed-show-all ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-all"))
(defun gps/elfeed-show-emacs ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-emacs"))
(defun gps/elfeed-show-daily ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-daily"))
  
(defun gps/elfeed-show-economics ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-economics"))
(defun gps/elfeed-show-prgramming ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-programming"))
(defun gps/elfeed-show-phd ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-phd"))  
;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun gps/elfeed-load-db-and-open ()
"Load the elfeed db from disk before updating."
	(interactive)
	(elfeed)
	(elfeed-db-load)
	(elfeed-search-update--force)
	(elfeed-update))

;;write to disk when quiting
(defun gps/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))
  
(defun gps/elfeed-mark-all-as-read ()
      (interactive)
      (mark-whole-buffer)
      (elfeed-search-untag-all-unread)) 
 
(use-package elfeed
  :ensure t
  :bind (:map elfeed-search-mode-map
              ("A" . gps/elfeed-show-all)
              ("E" . gps/elfeed-show-emacs)
              ("D" . gps/elfeed-show-daily)
              ("H" . gps/elfeed-show-phd)
              ("P" . gps/elfeed-show-programming)
              ("N" . gps/elfeed-show-economics)
              ("R" . gps/elfeed-mark-all-as-read)
              ("q" . gps/elfeed-save-db-and-bury)))

(use-package ox-reveal
:ensure ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(use-package htmlize
:ensure t)

;;(load-file "~/scimax/ob-julia.el")
(require 'ess-site)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional
(setq jedi:environment-root "jedi")  ; or any other name you like
(setq py-python-command "/usr/bin/python3")
(setq elpy-rpc-python-command "python3")
(setq jedi:environment-virtualenv
      (append python-environment-virtualenv
              '("--python" "/usr/bin/python3")))

(add-hook 'after-init-hook 'global-company-mode)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (ipython . t)
   (jupyter . t)
   (octave . t)
   (julia . t)
   ))

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "biber %b"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-latex-prefer-user-labels t)

(citeproc-org-setup)

(use-package company
  :defer 0.5
  :delight
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package company-anaconda
  :after (anaconda-mode company)
  :config (add-to-list 'company-backends 'company-anaconda))

(require 'company-statistics)
(company-statistics-mode)

(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1)               ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t)

;; (setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
;; (setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
;; (ergoemacs-mode 1)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(require 'which-key)
(use-package which-key
  :defer 0.2
  :diminish
  :config (which-key-mode))

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(org-babel-load-file "~/scimax/scimax-editmarks.org")

(setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))
(setq ivy-initial-inputs-alist nil)

(global-linum-mode t)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-list-allow-alphabetical t)

(use-package flyspell
  :defer t
  :ensure t)

(use-package pdf-tools
  :defer 1
  :magic ("%PDF" . pdf-view-mode)
  :init (pdf-tools-install :no-query))

(use-package pdf-view
  :ensure nil
  :after pdf-tools
  :bind (:map pdf-view-mode-map
              ("C-s" . isearch-forward)
              ("d" . pdf-annot-delete)
              ("h" . pdf-annot-add-highlight-markup-annotation)
              ("t" . pdf-annot-add-text-annotation))
  :custom
  (pdf-view-display-size 'fit-page)
  (pdf-view-resize-factor 1.1)
  (pdf-view-use-unicode-ligther nil))

;;(require 'scimax-dashboard)
;;(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(setq org-default-notes-file (concat  "~/Dropbox/Emacs/notes.org"))
     (define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/Emacs/notes.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
	("s" "Scheduled TODO" entry (file+headline as/gtd "Collect")
	     "* TODO %? %^G \nSCHEDULED: %^t\n  %U" :empty-lines 1)
        ("d" "Deadline" entry (file+headline as/gtd "Collect")
            "* TODO %? %^G \n  DEADLINE: %^t" :empty-lines 1)
        ("p" "Priority" entry (file+headline as/gtd "Collect")
        "* TODO [#A] %? %^G \n  SCHEDULED: %^t")
        ("P" "Pessoal" entry (file  "~/Dropbox/Emacs/Gmail.org" )
"* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
        ("U" "Unicamp" entry (file  "~/Dropbox/Emacs/Unicamp.org" )
"* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
	("g" "Generic idea" entry (file "~/Dropbox/Emacs/idea.org")
	     "* TODO %?\n  %i\n  %a")
	("c" "calfw2org" entry (file nil)
	    "* %?\n %(cfw:org-capture-day)")

))

(use-package calfw
:ensure ;TODO:
:config
(require 'calfw)
(require 'calfw-org)
(setq cfw:org-overwrite-default-keybinding t)
(require 'calfw-ical)

(defun mycalendar ()
(interactive)
(cfw:open-calendar-buffer
:contents-sources
(list
    (cfw:org-create-source "IndianRed")  ; orgmode source
(cfw:ical-create-source "Unicamp" "https://calendar.google.com/calendar/ical/g155468@dac.unicamp.br/private-cb1bfc11310f03608d8a284b97d627a4/basic.ics" "Green")
(cfw:ical-create-source "Pessoal" "https://calendar.google.com/calendar/ical/gpetrinidasilveira@gmail.com/private-232b3fff9ab59f9953d4cebf83d7f189/basic.ics" "Orange")
(cfw:ical-create-source "Karina" "https://calendar.google.com/calendar/ical/karina.lopesbernardi@gmail.com/private-581ba6c17a09db84bdd66bf83b70174c/basic.ics" "RosyBrown")
(cfw:ical-create-source "Sraffianismo Tardio" "https://calendar.google.com/calendar/ical/unicamp.br_classroomfeeb9365@group.calendar.google.com/private-43ab6439b8f4f8746ca64191c82e0854/basic.ics" "Purple")
(cfw:ical-create-source "Cecon" "https://calendar.google.com/calendar/ical/unicamp.br_9lp6qlphk264nikd6oe2crk1es@group.calendar.google.com/private-1fffc0f45f6426b505ce490a37a138ee/basic.ics" "Red")
(cfw:ical-create-source "PED" "https://calendar.google.com/calendar/ical/unicamp.br_it3j901am0drhg87mg5h3u1dn0@group.calendar.google.com/private-543a0c1dba5acf1500da73ccec1e4fa6/basic.ics" "Brown")
)))
(setq cfw:org-overwrite-default-keybinding t))

(use-package calfw-gcal
:ensure t
:config
(require 'calfw-gcal))
