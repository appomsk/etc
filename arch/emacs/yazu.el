;; ;; Does not work with evil-mode
;; (defun reverse-input-method (input-method)
;;   "Build the reverse mapping of single letters from INPUT-METHOD."
;;   (interactive
;;    (list (read-input-method-name "Use input method (default current): ")))
;;   (if (and input-method (symbolp input-method))
;;       (setq input-method (symbol-name input-method)))
;;   (let ((current current-input-method)
;;         (modifiers '(nil (control) (meta) (control meta))))
;;     (when input-method
;;       (activate-input-method input-method))
;;     (when (and current-input-method quail-keyboard-layout)
;;       (dolist (map (cdr (quail-map)))
;;         (let* ((to (car map))
;;                (from (quail-get-translation
;;                       (cadr map) (char-to-string to) 1)))
;;           (when (and (characterp from) (characterp to))
;;             (dolist (mod modifiers)
;;               (define-key (if mod input-decode-map local-function-key-map)
;;                 (vector (append mod (list from)))
;;                 (vector (append mod (list to)))))))))
;;     (when input-method
;;       (activate-input-method current))))

;; ;; TODO comments
(load "$HOME/etc/conf/misc/emacs/russian-computer-noyo.el")
;; (reverse-input-method 'russian-computer-noyo)
(activate-input-method 'russian-computer-noyo)

;; evil
(evil-mode 1)

; No need now --- otherwise always black
; (setq evil-default-cursor t)

;;; settings
;; vim nostartofline
(setq evil-cross-lines t)
;; do not move cursor back
(setq evil-move-cursor-back nil)

;;; more emacs
;; was evil-copy-from-below
(define-key evil-insert-state-map "\C-e" 'end-of-line)
;; was evil-insert-digraph
(define-key evil-insert-state-map "\C-k" 'kill-line)
;; was evil-complete-previous - use M-/, C-M-/
(define-key evil-insert-state-map "\C-p" 'previous-line)
;; was evil-complete-next
(define-key evil-insert-state-map "\C-n" 'next-line)

;;; more lynx
(define-key evil-normal-state-map (kbd "SPC") 'scroll-up-command)
(define-key evil-normal-state-map [backspace] 'scroll-down-command)

;; doesn't work
(define-key evil-visual-state-map (kbd "SPC") 'cua-scroll-up)
(define-key evil-visual-state-map [backspace] 'cua-scroll-down)

;;; my
(define-key evil-normal-state-map [(control return)]
  '(lambda ()
     (interactive)
     (evil-insert-state)
     (evil-ret)
     (evil-normal-state)))

;;try
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
