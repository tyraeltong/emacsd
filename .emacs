;; Time-stamp: <2012-09-01 23:58:04 Saturday by tyraeltong>
(server-start)
(set-face-attribute 'default nil :height 180)
(setq-default tab-width 2)
(add-to-list 'load-path "~/.emacs.d")
(defconst my-emacs-path "~/.emacs.d/" "my emacs configuration files path")
(defconst my-emacs-my-lisps-path (concat my-emacs-path "my-lisps/") "my own lisp files")
(defconst my-emacs-lisps-path (concat my-emacs-path "lisps/") "my downloaded lisp files")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/") "my templates")
(defconst my-elpa-path (concat my-emacs-path "elpa"))

(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-elpa-path)
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)

(setq backup-inhibited t)
(setq auto-save-default nil)

(require 'eval-after-load)
(require 'util)
(require 'ahei-misc)
(require 'coding-settings)
(require 'misc-settings)
(require 'my-mac-settings)
(require 'my-emacs-face-settings)
(require 'my-org-settings)
(require 'my-ruby-settings)
(require 'my-webdev-settings)
(require 'my-auto-complete-settings)
(require 'time-stamp-settings)
(require 'browse-kill-ring-settings)
(require 'autopair-settings)
;; (require 'rect-mark-settings)

;; (require 'ascii)
(require 'hexview-mode)

;; change to use elpa
(require 'undo-tree)
(global-undo-tree-mode t)

;; change to use elpa
(require 'fuzzy)
(turn-on-fuzzy-isearch)

;; this fancy, but not very useful
;; (require 'highlight-tail)
;; (highlight-tail-mode)

;; Comment out, there're some format issue
;; (load-file "~/.emacs.d/online-search.el")
;; (global-set-key [(control c) (s)] 'online-search)
;; (setq is-plaintext-enable 't)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'coffee-mode)
(defun coffee-custom()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook
          '(lambda() (coffee-custom)))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.Cakefile" . coffee-mode))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq mac-option-modifier 'super)

(global-set-key [(meta =)] 'text-scale-increase)
(global-set-key [(meta +)] 'text-scale-decrease)

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.run$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; (require 'all-buffer-settings)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-level 2)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2)
 '(js2-cleanup-whitespace t)
 '(js-indent-level 2)
 '(js2-electric-keys (quote nil)))

(global-linum-mode t)
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US
(load "~/.emacs.d/ergoemacs-keybindings-5.3.9/ergoemacs-mode")
(ergoemacs-mode 1)
;; reset ctrl+f to grep-find. ergoemacs set it to search-forward, which is not suitable for me
(global-set-key [(ctrl f)] 'grep-find)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setenv "DYLD_LIBRARY_PATH" "/usr/local/mysql/lib/")
(setenv "TERM" "xterm-256color")
(defadvice ansi-term (after advise-ansi-term-coding-system)
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-activate 'ansi-term)
;;(setq highlight-tail-steps 7
;;      highlight-tail-timer 0.5)
(add-to-list 'load-path "~/.emacs.d/expand-region.el")
(require 'expand-region)
(global-set-key [(meta 2)] 'er/expand-region)

(global-set-key [(meta t)] 'textmate-goto-file)
(global-set-key [(meta T)] 'textmate-goto-symbol)

;; using Aspell to replace ispell
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")       ; Flyspell uses "-l" with ispell for faster region checking. The equivalent aspell command is "list"
(setq ispell-extra-args '("--sug-mode=ultra"))

;; mark
(when (require 'auto-mark nil t)
  (setq auto-mark-command-class-alist
        '((anything . anything)
          (goto-line . jump)
          (indent-for-tab-command . ignore)
          (undo . ignore)))
  (setq auto-mark-command-classifiers
        (list (lambda (command)
                (if (and (eq command 'self-insert-command)
                         (eq last-command-char ? ))
                    'ignore))))
  (global-auto-mark-mode 1))
;; visible mark mode
(require 'visible-mark)
(visible-mark-mode t)
(global-visible-mark-mode t)
;;(global-auto-mark-mode t)

;;(setq linum-format "   %d  ")
;; rsense, this seems not work with RVM, yet.
;; (setq rsense-home "~/.emacs.d/rsense")
;; (add-to-list 'load-path (concat rsense-home "/etc"))
;; (require 'rsense)

;; add ack into execute path
(setq exec-path (append exec-path '("/usr/local/bin/")))

;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; scss mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/scss-mode"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'jade-mode)

;; markdown mode
(autoload 'markdown-mode "markdown-mode")
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; compile using marked.app
(defun markdown-preview-file ()
  "run Marked on the current file and revert the buffer"
  (interactive)
  (shell-command
   (format "open -a /Applications/Marked.app %s"
           (shell-quote-argument (buffer-file-name))))

)

(global-set-key "\C-cm" 'markdown-preview-file)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; helm, formerly anything
(global-set-key [(ctrl a)] 'helm-mini)

(global-set-key (kbd "C-x b")
                (lambda() (interactive)
                  (helm
                   :prompt "Switch to: "
                   :candidate-number-limit 10
                   :sources
                   '( helm-c-source-buffers-list
                      helm-c-source-recentf
                      helm-c-source-bookmarks
                      helm-c-source-files-in-current-dir
                      helm-c-source-locate
                      ))))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)
