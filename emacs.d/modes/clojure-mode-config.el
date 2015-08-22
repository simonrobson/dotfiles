(require 'clj-refactor)

(defun configure-clj-refactor ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'configure-clj-refactor)
(require 'clojure-mode-extra-font-locking)
