(add-to-list 'package-selected-packages 'ess)
(add-to-list 'package-selected-packages 'conda)
(add-to-list 'package-selected-packages 'pyvenv)
(add-to-list 'package-selected-packages 'pythonic)
(add-to-list 'package-selected-packages 'poetry)
(add-to-list 'package-selected-packages 'flx)
(add-to-list 'package-selected-packages 'counsel)

(add-to-list 'package-selected-packages 'elfeed)
(add-to-list 'package-selected-packages 'elfeed-org)
(add-to-list 'package-selected-packages 'org-journal)

(add-to-list 'package-selected-packages 'spacemacs-theme)
(add-to-list 'package-selected-packages 'ergoemacs-mode)

(custom-set-variables
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(font-use-system-font t)
 '(org-agenda-files (quote ("~/Dropbox/Emacs/Todos.org"))))
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

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (ipython . t)
   (jupyter . t)
   (octave . t)
   (C . t)
   (shell . t)
   ))

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "biber %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))

(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1)               ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t)

;; (setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
;; (setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
;; (ergoemacs-mode 1)



(use-package which-key
	:ensure t
	:config 
	(progn
	  (wich-key-setup-side-window-right-bottom)
	  (which-key-mode)
	)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))
(setq ivy-initial-inputs-alist nil)

(global-linum-mode t)

(use-package flyspell
  :defer t
  :ensure t)

;; Don't remove this:
(unless (every 'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (package-install-selected-packages))
