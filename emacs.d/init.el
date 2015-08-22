(setq shr-emacs-init-file load-file-name)
(setq shr-emacs-config-dir
      (file-name-directory shr-emacs-init-file))
(setq user-emacs-directory shr-emacs-config-dir)

(add-to-list 'load-path (concat shr-emacs-config-dir (file-name-as-directory "modes")))

(setq custom-file (expand-file-name "emacs-customizations.el" shr-emacs-config-dir))
(load custom-file)

(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))

(setq package-archives
'(("melpa" . "http://melpa.org/packages/")
  ("gnu" . "http://elpa.gnu.org/packages/")
  ;;("marmalade" . "http://marmalade-repo.org/packages/")
  ))
(package-initialize)
(setq abg-required-packages
      (list 'magit
	    'clojure-mode 'clojure-mode 'clojure-mode-extra-font-locking 'cider 'clj-refactor
	    'paredit
	    'evil))
(dolist (package abg-required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))

(setq linum-format "%2d ")
(add-hook 'prog-mode-hook (lambda ()
			    (linum-mode 1)
			    (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(load "clojure-mode-config.el")
(load "evil-mode-config.el")

(load (expand-file-name "tmux-keymap-fixes.el" shr-emacs-config-dir))
