;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;; vim: syntax=lisp: foldmethod=marker

;; {{{ Prelude

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; (package-refresh-contents)

;; }}}
;; {{{ Russification

;;;; Just for example
;; Needed for `:after char-fold' to work
(use-package char-fold
  :custom
  (char-fold-symmetric t)
  (search-default-mode #'char-fold-to-regexp))

(load 
  (concat (getenv "ETC") "/apps/emacs/russian-computer-noyo.el"))

(use-package reverse-im
  :ensure t ; install `reverse-im' using package.el
  :demand t ; always load it
  :after char-fold ; but only after `char-fold' is loaded
  :bind
  ("M-T" . reverse-im-translate-word) ; fix a word in wrong layout
  :custom
  (reverse-im-char-fold t) ; use lax matching
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  (reverse-im-input-methods '("russian-computer-noyo")) ; translate these methods
  :config
  (reverse-im-mode t)) ; turn the mode on

;; }}}
;; {{{ UI



;; }}}
;; {{{ Tweaks

;; (setq xclip-program "powershell.exe")
(setq xclip-program "xclip")

;; some stealing settings
(setq undo-limit 80000000)                         ; Raise undo-limit to 80Mb
(setq auto-save-default t)                         ; Nobody likes to loose work, I certainly don't

;; Disabling Prompts

;; y-or-no-p already done in doom
;;(fset 'yes-or-no-p 'y-or-no-p)
(setq confirm-nonexistent-file-or-buffer nil)

;; silly questions
(setq confirm-kill-emacs nil)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
        kill-buffer-query-functions))

(add-hook 'text-mode-hook 'auto-fill-mode)
; (set-fill-column 72)

;; }}}
;; {{{ Evil

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;;(use-package 'evil-terminal-cursor-changer
;;  (evil-terminal-cursor-changer t))
(unless (display-graphic-p) 
  (require 'evil-terminal-cursor-changer)
  (setq etcc-use-blink nil)
  (evil-terminal-cursor-changer-activate)) ; or (etcc-on)

;; }}}
;; {{{ Keys

;; windmove
(windmove-default-keybindings)

;;; Insert state
(setf evil-disable-insert-state-bindings t)

;; TODO was company-yasnippet - originally with "C-c y"
(evil-global-set-key 'insert (kbd "M-c") (kbd "C-g"))

(evil-define-key 'insert 'global (kbd "C-l") (kbd ":noh"))
;; disable-insert-state doesn't work
;; was (company-files COMMAND &optional ARG &rest IGNORED)
(evil-define-key 'insert 'global (kbd "C-x C-f") 'counsel-find-file)
(evil-define-key 'insert 'global (kbd "C-k") 'kill-line)
(evil-define-key 'insert 'global (kbd "M-k") 'evil-insert-digraph)

;;; Normal
;(evil-define-key 'normal 'global (kbd "M-SPC") " ")
;(evil-define-key 'normal 'global "Q" "gqap")

;; Fixes
(evil-define-key 'normal Info-mode-map (kbd "C-i") 'Info-next-reference)
(add-hook 'evil-collection-setup-hook (lambda (&rest argv)
        (evil-collection-define-key 'normal 'Info-mode-map
          ;; fix for terminal - C-i == TAB
          ;; C-i is used for Info-history-forward - I do not a good key for it
          (kbd "C-i") 'Info-next-reference)))

; map! doesn't work (it's DOOM feature)
; was projectile-find-file. It's also binded to SPC p f
; (map! :leader
;      :desc "Page Down" :n "SPC" 'evil-scroll-page-down)
;; (map! :leader :map 'Info-mode-map "SPC" 'Info-scroll-up)
; it does not work but doom defines C-RET and S-RET and C-S-RET in :gi
; Try to use because in insert mode it's useful and in global - just the same
;(evil-define-key 'normal 'global (kbd "<C-Return>") "i\C-m\C-[")

;; }}}
;; {{{ Custom

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-enabled-themes '(gruvbox-dark-soft))
 '(custom-safe-themes
   '("a5270d86fac30303c5910be7403467662d7601b821af2ff0c4eb181153ebfc0a" "7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" "871b064b53235facde040f6bdfa28d03d9f4b966d8ce28fb1725313731a2bcc8" "046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d" default))
 '(desktop-save-mode t)
 '(etcc-use-blink nil)
 '(menu-bar-mode nil)
 '(package-selected-packages '(gruvbox-theme reverse-im))
 '(save-place-mode t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; }}}
