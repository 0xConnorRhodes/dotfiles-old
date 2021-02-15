;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
 
;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.doom.d/lisp/")
;; later in the config load the packaged named xyz.
;(load "xyz") ;; best not to include the ending “.el” or “.elc”
;; load the packaged named xyz.
;(after! org
;(load "org-mode-inline-comments") ;; best not to include the ending “.el” or “.elc”
;)
; note: adding adds inline comments but breaks syntax highlighting so disabled for now


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Connor Rhodes"
      user-mail-address "cnnrrhodes@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "DroidSansMono Nerd Font" :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dox/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


; my setqs
(setq confirm-kill-emacs nil)
(setq auto-revert-verbose nil) ;supresses auto-revert-mode file updated messages

; my hooks
(add-hook 'org-mode-hook (lambda() (ws-butler-mode -1))) ; disables ws-butler in org mode
(add-hook 'org-mode-hook #'auto-revert-mode)
(add-hook 'org-mode-hook #'turn-off-smartparens-mode) ;disable closing brackets and parenthesis in org mode

; autosave on exit insert mode
(defun my-save-if-bufferfilename ()
  (if (buffer-file-name)
      (progn
        (save-buffer)
        )
    (message "no file is associated to this buffer: do nothing")
    )
)
(add-hook 'evil-insert-state-exit-hook 'my-save-if-bufferfilename)



; disable the endless list of minor modes
(setq mode-line-modes
      (mapcar (lambda (elem)
                (pcase elem
                  (`(:propertize (,_ minor-mode-alist . ,_) . ,_)
                   "")
                  (t elem)))
              mode-line-modes))

;; Backup files settings (the ~ files)
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.local/config_sync/emacs_backup_files/"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 4
      version-control t)       ; use versioned backups
(setq auto-save-file-name-transforms
      `((".*" "~/.local/config_sync/emacs_backup_files/" t)))
;; enable autosave by default
(setq auto-save-default t) ; autosave by default
(setq auto-save-timeout 5) ; autosave after 5 idle seconds
(setq auto-save-visited-mode t) ; autosave file visiting buffers every 10 seconds
(setq auto-save-no-message t) ; disable autosave message 
(setq auto-save-interval 20) ; 20 is the minimum autosave interval
; auto save to original file every X seconds
(add-hook 'auto-save-hook 'org-save-all-org-buffers)
; disable messages from autosave
(add-hook 'auto-save-hook 'auto-save-silence+)
(defun auto-save-silence+ ()
  (setq inhibit-message t)
  (run-at-time 0 nil
               (lambda ()
                 (setq inhibit-message nil))))


; org-table-wrap-functions config
(use-package! org-table-wrap-functions)

;; keys
(setq x-alt-keysym 'meta) ; binds alt as meta as well since I actually have a meta key

; org mode
(after! org
    (setq org-todo-keywords
        '((sequence "(x)" "TODO(t)" "STRT(s)" "NEXT(n)" "HOLD(h)" "WAIT(w)" "REV(r)" "|" "DONE(d)" "KILL(k)" "TMRW(m)")))
; org-mode visual settings
; 

(setq org-highlight-latex-and-related nil
      org-startup-indented t
      org-startup-folded t)
      )

(put 'narrow-to-region 'disabled nil)



; emacs zoom window
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(zoom-window-mode-line-color "nil"))

; emacs custom functions

;; create vertical split and clone to indirect buffer
(defun clone-vsplit ()
  "create vertical split and clone current buffer into it"
  (interactive)
  (evil-window-vsplit nil)
  (clone-indirect-buffer nil t))

(setq company-global-modes '(not org-mode)) ; disable company completion in org mode

;; delete currently opened file
(defun rm-file ()
  (interactive)
  (progn
    (kill-new (buffer-string))
    (when (buffer-file-name)
      (when (file-exists-p (buffer-file-name))
        (progn
          (delete-file (buffer-file-name))
          (message "Deleted file: 「%s」." (buffer-file-name)))))
    (let ((buffer-offer-save nil))
      (set-buffer-modified-p nil)
      (kill-buffer (current-buffer)))))

; custom keybindings
(map! :leader :desc "Zoom into Emacs Window" "e" #'zoom-window-zoom)
(map! :leader :desc "create vertical split and clone current buffer into it" "c" #'clone-vsplit)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
