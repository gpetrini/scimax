(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(with-eval-after-load 'tls
    (push "/usr/local/etc/libressl/cert.pem" gnutls-trustfiles))

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
(add-to-list 'package-selected-packages 'exec-path-from-shell)
;; (add-to-list 'package-selected-packages 'ob-julia)
;; (add-to-list 'load-path "~/scimax/ob-julia.el")

(add-to-list 'package-selected-packages 'ox-reveal)
(add-to-list 'package-selected-packages 'citeproc-org)
(add-to-list 'package-selected-packages 'academic-phrases)

(add-to-list 'package-selected-packages 'elfeed)
(add-to-list 'package-selected-packages 'elfeed-org)
(add-to-list 'package-selected-packages 'org-journal)

(add-to-list 'package-selected-packages 'spacemacs-theme)
(add-to-list 'package-selected-packages 'ergoemacs-mode)
(add-to-list 'package-selected-packages 'dashboard)
(add-to-list 'package-selected-packages 'pdf-tools)
(add-to-list 'package-selected-packages 'org-superstar)

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

(setq org-ellipsis " ")
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-export-with-smart-quotes t)

(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

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

(use-package poly-org
  :ensure t)
;; Add company:
(use-package company
  :ensure t)
;; Tweaks for company:
(add-hook 'after-init-hook 'global-company-mode)
(setq company-global-modes '(not org-mode text-mode))
(setq ess-use-company 'script-only)
;; Add company quickhelp:
(use-package company-quickhelp
  :ensure t
  :config
  (company-quickhelp-mode))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "SPC") #'company-abort))

(add-to-list 'load-path "~/scimax/user/ado-mode/lisp")
(require 'ado-mode)

 (when (functionp 'module-load)
     (use-package jupyter)
     (with-eval-after-load 'org
       (org-babel-do-load-languages
	'org-babel-load-languages
	'((jupyter . t))))
     (with-eval-after-load 'jupyter
       (define-key jupyter-repl-mode-map (kbd "C-l") #'jupyter-repl-clear-cells)
       (define-key jupyter-repl-mode-map (kbd "TAB") #'company-complete-common-or-cycle)
       (define-key jupyter-org-interaction-mode-map (kbd "TAB") #'company-complete-common-or-cycle)
       (define-key jupyter-repl-interaction-mode-map (kbd "C-c C-r") #'jupyter-eval-line-or-region)
       (define-key jupyter-repl-interaction-mode-map (kbd "C-c M-r") #'jupyter-repl-restart-kernel)
       (define-key jupyter-repl-interaction-mode-map (kbd "C-c M-k") #'jupyter-shutdown-kernel)
       (add-hook 'jupyter-org-interaction-mode-hook (lambda () (company-mode)
						     (setq company-backends '(company-capf))))
       (add-hook 'jupyter-repl-mode-hook (lambda () (company-mode)
					  :config (set-face-attribute
						   'jupyter-repl-input-prompt nil :foreground "black")
					  :config (set-face-attribute
						   'jupyter-repl-output-prompt nil :foreground "grey")
					  (setq company-backends '(company-capf))))
       (setq jupyter-repl-prompt-margin-width 4)))

   ;; associated jupyter-stata with stata (fixes fontification if using pygmentize for html export)
   (add-to-list 'org-src-lang-modes '("jupyter-stata" . stata))
   (add-to-list 'org-src-lang-modes '("Jupyter-Stata" . stata)) 
   ;; you **may** need this for latex output syntax highlighting
 (add-to-list 'org-latex-minted-langs '(stata "stata"))
 (setq inferior-STA-program-name "/usr/local/bin/jupyter-console")

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Load ob-julia and dependencies
(use-package julia-mode
  :ensure t)
(add-to-list 'load-path "~/ob-ess-julia/") ; replace by your own path
(require 'ob-ess-julia)
;; Link this language to ess-julia-mode (although it should be done by default):
(setq org-src-lang-modes
      (append org-src-lang-modes '(("ess-julia" . ess-julia))))


(add-to-list 'org-structure-template-alist
	     '("j" . "src ess-julia :results output :session *julia* :exports both"))
;; Shortcut for inline graphical output within a session:
(add-to-list 'org-structure-template-alist
	     '("jfig" . "src ess-julia :results output graphics file :file FILENAME.png :session *julia* :exports both"))
;; Shortcut for well-formatted org table output within a session:
(add-to-list 'org-structure-template-alist
	     '("jtab" . "src ess-julia :results value table :session *julia* :exports both :colnames yes"))

(with-eval-after-load 'python
  (add-hook 'python-mode-hook (lambda () (setq python-shell-interpreter "python3"))))
(setq elpy-rpc-python-command "python3")

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

(use-package auto-complete
:ensure t
:init
(progn
(ac-config-default)
(global-auto-complete-mode t)
))

(setq py-python-command "/usr/bin/python3")
(setq python-shell-interpreter "python")

(use-package jedi
:ensure t
:init
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'jedi:ac-setup))

(add-hook 'python-mode-hook 'yas-minor-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

(with-eval-after-load 'company
    (add-hook 'python-mode-hook 'company-mode))

(use-package company-jedi
  :ensure t
  :config
    (require 'company)
    (add-to-list 'company-backends 'company-jedi))

(defun python-mode-company-init ()
  (setq-local company-backends '((company-jedi
                                  company-etags
                                  company-dabbrev-code))))

(load "~/scimax/dynare.el")

(add-hook 'shell-mode-hook 'yas-minor-mode)
(add-hook 'shell-mode-hook 'flycheck-mode)
(add-hook 'shell-mode-hook 'company-mode)

(defun shell-mode-company-init ()
  (setq-local company-backends '((company-shell
                                  company-shell-env
                                  company-etags
                                  company-dabbrev-code))))

(use-package company-shell
  :ensure t
  :config
    (require 'company)
    (add-hook 'shell-mode-hook 'shell-mode-company-init))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'yas-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'company-mode)

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

(use-package slime-company
  :ensure t
  :init
    (require 'company)
    (slime-setup '(slime-fancy slime-company)))

(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)

(use-package flycheck-clang-analyzer
  :ensure t
  :config
  (with-eval-after-load 'flycheck
    (require 'flycheck-clang-analyzer)
     (flycheck-clang-analyzer-setup)))

(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))

(use-package company-c-headers
  :ensure t)

(use-package company-irony
  :ensure t
  :config
  (setq company-backends '((company-c-headers
                            company-dabbrev-code
                            company-irony))))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   ;; (ipython . t) ;; As indicated here https://rlhick.people.wm.edu/posts/stata_kernel_emacs.html
   (jupyter . t)
   (octave . t)
   (stata . t)
   ;; (jupyter-stata . t)
   (ess-julia . t)))

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "biber %b"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-latex-prefer-user-labels t)

(citeproc-org-setup)

  (use-package iedit
    :ensure t)

(use-package avy
  :ensure t
  :bind
    ("M-s" . avy-goto-char))

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

(use-package mark-multiple
  :ensure t
  :bind ("C-." . 'mark-next-like-this))

(global-linum-mode t)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-list-allow-alphabetical t)

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
    (setq spaceline-buffer-encoding-abbrev-p nil)
    (setq spaceline-line-column-p nil)
    (setq spaceline-line-p nil)
    (setq powerline-default-separator (quote arrow))
    (spaceline-spacemacs-theme))

(when window-system
      (use-package pretty-mode
      :ensure t
      :config
      (global-pretty-mode t)))

  (use-package synosaurus
  :ensure t)

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

;; (require 'scimax-dashboard)
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(use-package dashboard
  :ensure t
  :config
    (dashboard-setup-startup-hook)
    (setq dashboard-startup-banner "~/.emacs.d/img/dashLogo.png")
    (setq dashboard-items '((recents  . 5)
                            (projects . 5)))
    (setq dashboard-banner-logo-title ""))

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

(use-package magit
  :ensure t
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  :bind
  ("M-g" . magit-status))

(use-package async
  :ensure t
  :init (dired-async-mode 1))

(use-package projectile
  :ensure t
  :init
  (projectile-mode 1))

(global-set-key (kbd "<f5>") 'projectile-compile-project)

(use-package rainbow-mode
  :ensure t
  :init
    (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package hungry-delete
  :ensure t
  :config
    (global-hungry-delete-mode))

(defun config-reload ()
  "Reloads ~/.emacs.d/config.org at runtime"
  (interactive)
  (org-babel-load-file (expand-file-name "~/scimax/user/README.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(setq electric-pair-pairs '(
                           (?\{ . ?\})
                           (?\( . ?\))
                           (?\[ . ?\])
                           (?\" . ?\")
                           ))
(setq electric-pair-inhibit-predicate
      `(lambda (c)
         (if (char-equal c ?\<) t (,electric-pair-inhibit-predicate c))))
(electric-pair-mode t)

(add-to-list 'org-structure-template-alist
	     '("el" . "src elisp"))

(use-package helm
  :ensure t
  :bind
  ("C-x C-f" . 'helm-find-files)
  ("C-x C-b" . 'helm-buffers-list)
  ("M-x" . 'helm-M-x)
  :config
  (defun gps/helm-hide-minibuffer ()
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face
                     (let ((bg-color (face-background 'default nil)))
                       `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))
  (add-hook 'helm-minibuffer-set-up-hook 'gps/helm-hide-minibuffer)
  (setq helm-autoresize-max-height 0
        helm-autoresize-min-height 40
        helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-split-window-in-side-p nil
        helm-move-to-line-cycle-in-source nil
        helm-ff-search-library-in-sexp t
        helm-scroll-amount 8 
        helm-echo-input-in-header-line t)
  :init
  (helm-mode 1))

(require 'helm-config)    
(helm-autoresize-mode 1)
(define-key helm-find-files-map (kbd "C-b") 'helm-find-files-up-one-level)
(define-key helm-find-files-map (kbd "C-f") 'helm-execute-persistent-action)
