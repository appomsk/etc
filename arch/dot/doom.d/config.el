;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;; vim: syntax=lisp: foldmethod=marker

;;;; {{{ Prelude
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;; }}}
;;;; {{{ Russification

(load "$HOME/etc/conf/misc/emacs/russian-computer-noyo.el")

(use-package! reverse-im
  :custom
  (reverse-im-input-methods '("russian-computer-noyo"))
  :config
  (reverse-im-mode t))

;;;; }}}
;;;; {{{ UI

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "UbuntuSansMono Nerd Font Mono" :height 131 :weight 'regular)
       doom-variable-pitch-font (font-spec :family "sans" :height 131))
;; '(default ((t (:family "Ubuntu Sans Mono" :foundry "DAMA" :slant normal :weight regular :height 131 :width normal))))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; kludge CHECK
(setq overflow-newline-into-fringe nil)

;; time
(display-time-mode 1)                             ; Enable time in the mode-line
(setq display-time-24hr-format 1)

;;;; }}}
;;;; {{{ Administrativa
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

;;;; }}}
;;;; {{{ Keys

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
; was projectile-find-file. It's also binded to SPC p f
(map! :leader
      :desc "Page Down" :n "SPC" 'evil-scroll-page-down)
;; (map! :leader :map 'Info-mode-map "SPC" 'Info-scroll-up)
; it does not work but doom defines C-RET and S-RET and C-S-RET in :gi
; Try to use because in insert mode it's useful and in global - just the same
;(evil-define-key 'normal 'global (kbd "<C-Return>") "i\C-m\C-[")
;;;; }}}
;;;; {{{ Evil
(setq evil-cross-lines t)

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

;;;; }}}
;;;; {{{ Org-mode
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/var/org/")

;; customizing with custom interface does not work
(custom-set-faces! '(org-hide :foreground "color-236"))

  (defun org-ctrl-return-around (org-fun &rest args)
    "Run `ober-eval-in-repl' if in source code block and `org-insert-heading-respect-content' otherwise."
    (if (org-in-block-p '("src" "example"))
        (ober-eval-in-repl)
      (apply org-fun args)))
  (advice-add 'org-insert-heading-respect-content :around #'org-ctrl-return-around)

  (defun org-meta-return-around (org-fun &rest args)
    "Run `ober-eval-block-in-repl' if in source code block or example block and `org-meta-return' otherwise."
    (if (org-in-block-p '("src" "example"))
        (ober-eval-block-in-repl)
      (apply org-fun args)))
  (advice-add 'org-meta-return :around #'org-meta-return-around)

(after! org
  (setq org-startup-indented nil)
  (setq org-adapt-indentation nil)  ;; for two-lines headers there is another option
  (setq org-hide-emphasis-markers t)
;  (setq org-hide-leading-stars nil)
; IT DOESN'T WORK:
;  (define-key org-mode-map (kbd "<C-return>") nil)
  )

(after! evil-org
(evil-define-key 'normal evil-org-mode-map (kbd "<C-return>") nil)
(evil-define-key 'insert evil-org-mode-map (kbd "<C-return>") nil)
(evil-define-key 'normal evil-org-mode-map (kbd "<S-return>")
  'electric-indent-just-newline)
(evil-define-key 'insert evil-org-mode-map (kbd "<S-return>") nil)
(evil-define-key 'normal evil-org-mode-map (kbd "<C-S-return>") nil)
(evil-define-key 'insert evil-org-mode-map (kbd "<C-S-return>") nil)
  (evil-define-key 'insert evil-org-mode-map (kbd "C-k") nil))
;;;; }}}
;;;; {{{ Helpful
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)

(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)

;; FROM README: I also recommend the following keybindings to get the most out
;; of helpful:

;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;;
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)

;; Look up *C*ommands.
;;
;; By default, C-h C is bound to describe `describe-coding-system'. I
;; don't find this very useful, but it's frequently useful to only
;; look at interactive functions.
(global-set-key (kbd "C-h C") #'helpful-command)

;;; FROM README: Ivy users can use Helpful with counsel commands:

(setq counsel-describe-function-function #'helpful-callable)
(setq counsel-describe-variable-function #'helpful-variable)

;; }}}
;;;; {{{ Eval-in-REPL
;; require the main file containing common functions
(require 'eval-in-repl)

;; Uncomment if no need to jump after evaluating current line
;; (setq eir-jump-after-eval nil)

;; Uncomment if you want to always split the script window into two.
;; This will just split the current script window into two without
;; disturbing other windows.
;; (setq eir-always-split-script-window t)

;; Uncomment if you always prefer the two-window layout.
;; (setq eir-delete-other-windows t)

;; Place REPL on the left of the script window when splitting.
(setq eir-repl-placement 'down)


;;; ielm support (for emacs lisp)
(require 'eval-in-repl-ielm)
;; Evaluate expression in the current buffer.
(setq eir-ielm-eval-in-current-buffer t)
;; for .el files
(define-key emacs-lisp-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
;; for *scratch*
(define-key lisp-interaction-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
;; for M-x info
;; (define-key Info-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)

;;; Geiser support (for Racket and Guile Scheme)
;; When using this, turn off racket-mode and scheme supports
;; (require 'geiser) ; if not done elsewhere
;; (require 'eval-in-repl-geiser)
;; (add-hook 'geiser-mode-hook
;; 		  #'(lambda ()
;; 		     (local-set-key (kbd "<C-return>") 'eir-eval-in-geiser)))

;;; racket-mode support (for Racket; if not using Geiser)
;; (require 'racket-mode) ; if not done elsewhere
;; (require 'eval-in-repl-racket)
;; (define-key racket-mode-map (kbd "<C-return>") 'eir-eval-in-racket)

;;; Scheme support (if not using Geiser))
;; (require 'scheme)    ; if not done elsewhere
;; (require 'cmuscheme) ; if not done elsewhere
;; (require 'eval-in-repl-scheme)
;; (add-hook 'scheme-mode-hook
;; 	  '(lambda ()
;; 	     (local-set-key (kbd "<C-return>") 'eir-eval-in-scheme)))

;;; Python support
;; (require 'python) ; if not done elsewhere
(require 'eval-in-repl-python)
(add-hook 'python-mode-hook
          #'(lambda ()
             (local-set-key (kbd "<C-return>") 'eir-eval-in-python)))

;;; Ruby support
;; (require 'ruby-mode) ; if not done elsewhere
;; (require 'inf-ruby)  ; if not done elsewhere
(require 'eval-in-repl-ruby)
(define-key ruby-mode-map (kbd "<C-return>") 'eir-eval-in-ruby)

;;; Prolog support (Contributed by m00nlight)
;; if not done elsewhere
;; (autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
;; (autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;; (autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
;; (setq prolog-system 'swi)
;; (setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
;;                                 ("\\.m$" . mercury-mode))
;;                                auto-mode-alist))
;(require 'eval-in-repl-prolog)
;(add-hook 'prolog-mode-hook
;          '(lambda ()
;             (local-set-key (kbd "<C-return>") 'eir-eval-in-prolog)))

;; Shell support
(require 'eval-in-repl-shell)
(add-hook 'sh-mode-hook
          #'(lambda()
             (local-set-key (kbd "C-<return>") 'eir-eval-in-shell)))
;; Version with opposite behavior to eir-jump-after-eval configuration
(defun eir-eval-in-shell2 ()
  "eval-in-repl for shell script (opposite behavior)

This version has the opposite behavior to the eir-jump-after-eval
configuration when invoked to evaluate a line."
  (interactive)
  (let ((eir-jump-after-eval (not eir-jump-after-eval)))
       (eir-eval-in-shell)))
(add-hook 'sh-mode-hook
          #'(lambda()
             (local-set-key (kbd "C-M-<return>") 'eir-eval-in-shell2)))

;;;; }}}
;;;; {{{ Prog-modes

;; disable - veeeeeery annoying
(flycheck-mode nil)

;; TODO
(add-hook! python-mode
  (setq python-shell-interpreter "ipython"))
(custom-set-faces! '(ein:cell-input-area :background "dark"))

;; configure perl settings

(defalias 'perl-mode 'cperl-mode)
(setq
 cperl-hairy t
 cperl-indent-level 2
 cperl-close-paren-offset -2
 cperl-continued-statement-offset 2
 cperl-indent-parens-as-block t
 cperl-tab-always-indent t)

;; Racket
;(add-hook 'racket-mode-hook #'racket-xp-mode)

;;;; }}}
;;;; {{{ Babel

;; babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (sh . t)
   (shell . t)
   (c . t)
   (ruby . t)
   (racket . t)
   (javascript . t)
   (js . t)
   ))

;; }}}
;;;; {{{ Misc
(add-hook 'text-mode-hook 'auto-fill-mode)
; (set-fill-column 72)

;; Kludge
(when window-system
  (set-frame-position (selected-frame) -1 0)
  (set-frame-size (selected-frame) 100 40))

;; try
(after! racket-mode
    (global-flycheck-mode 0))

(use-package! sweeprolog
              :mode (("\\.pl\\'"  . sweeprolog-mode)
                     ("\\.plt\\'" . sweeprolog-mode))) 


;; }}}
