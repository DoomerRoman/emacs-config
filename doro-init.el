(require 'server)
(server-start)

;; Hotkey RUS
(defun cfg:reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

;; auto install package
;; =============================================================================

(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; behavior
;; ============================================================================

(defalias 'yes-or-no-p 'y-or-n-p)

(setq help-window-select t)

(setq next-screen-context-lines 0)
;;(global-undo-tree-mode)
(transient-mark-mode t)
(electric-pair-mode t)
(setq show-trailing-whitespace t)

(setq require-final-newline    t)       
(setq require-final-newline    t)       
(setq next-line-add-newjlines nil)      

(delete-selection-mode t)

(setq scroll-step 1)
(setq scroll-margin 0)
(setq scroll-conservatively 10000)

(setq redisplay-dont-pause t)
(setq echo-keystrokes 0.001)

(defadvice compile (after jump-back activate)
  (switch-to-buffer-other-window "*compilation*"))

(show-paren-mode t)
(setq show-paren-style 'parenthesis)

;; Backup
;; ============================================================================

(setq auto-save-interval 512)
(setq auto-save-timeout 10)
(setq backup-directory-alist        
      '((".*" . "~/backups/emacs")))
(setq backup-by-copying t)
(setq version-control t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)


;; use-package
;; ============================================================================

(unless (package-installed-p 'use-package)
  (message "EMACS install use-package.el")
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'use-package)

(use-package delight
  :ensure t)

;; user mode
;; ============================================================================

(defvar doro-mode-map (make-sparse-keymap)
  "doro-mode editing commands key bindings")

(define-minor-mode doro-mode
  "doro minor mode"
  :init-value t
  doro-mode-map)

(defun turn-on-doro-mode ()
  (interactive)
  (doro-mode t))

(defun turn-off-doro-mode ()
  (interactive)
  (doro-mode -1))

;; Load options
;; ============================================================================

;; basic
(load "~/.emacs.d/doro-basic-keys")
(load "~/.emacs.d/doro-cua")
(load "~/.emacs.d/doro-avy")
(load "~/.emacs.d/doro-minibuffer")
(load "~/.emacs.d/doro-window")
(load "~/.emacs.d/doro-expand-region")
(load "~/.emacs.d/doro-dired")
(load "~/.emacs.d/doro-shell")

;; text
(load "~/.emacs.d/doro-text")
(load "~/.emacs.d/doro-comment")
(load "~/.emacs.d/doro-yasnippet")
(load "~/.emacs.d/doro-register")
(load "~/.emacs.d/doro-iedit") 
(load "~/.emacs.d/doro-multiple-cursors")
(load "~/.emacs.d/doro-drag-stuff")

;; lang
(load "~/.emacs.d/doro-indent")
(load "~/.emacs.d/doro-company")
(load "~/.emacs.d/doro-lsp")
(load "~/.emacs.d/doro-ag")
(load "~/.emacs.d/doro-dumb-jump")
(load "~/.emacs.d/doro-projectile")
(load "~/.emacs.d/doro-wgrep")

;; lang C++
(load "~/.emacs.d/doro-ccls")

;; lang javascript
(load "~/.emacs.d/doro-js2-mode")

;; theme
(load "~/.emacs.d/doro-theme")

;; other
(load "~/.emacs.d/doro-orgmode")

;; RUS Hotkey
(cfg:reverse-input-method 'russian-computer)
