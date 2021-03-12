;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dan Beauchesne"
      user-mail-address "dbeauchesne@gmail.com")

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
(setq doom-font (font-spec :family "PragmataPro" :size 17 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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

(require 'auth-source)
(require 'epa-file)
(epa-file-enable)

(after! mu4e
  (setq mail-user-agent 'mu4e-user-agent)

(defun insert-link-from-region ()
         "Create an org link where the selection is both the link and the description"
         (interactive)
         (save-excursion
           (let ((string (delete-and-extract-region (region-beginning)
                                                    (region-end) )))
             (when string
               (insert "[[")
               (insert string)
               (insert "][")
               (insert string)
               (insert "]]")))))

(defun insert-hyper-from-ip ()
         (interactive)
         (evil-visual-char)
         (forward-word)
         (forward-word)
         (forward-word)
         (forward-word)
         (let ((link (delete-and-extract-region (region-beginning)
                                                (region-end))))
           (when link
             (insert "[[https://")
             (insert link)
             (insert "][")
             (insert link)
             (insert "]]"))))

(setq mu4e-split-view "vertical")
(setq mu4e-update-interval (* 10 60))
(setq mu4e-get-mail-command "mbsync -a")
(setq mu4e-change-filenames-when-moving t)
(setq mu4e-compose-format-flowed t)
(setq mu4e-drafts-folder "/drafts")
(setq mu4e-sent-folder "/[Gmail]/Sent Mail")
(setq mu4e-refile-folder "/[Gmail]/All Mail")
(setq mu4e-trash-folder "/[Gmail]/Trash")
(setq mu4e-sent-messages-behavior 'delete)

(setq mu4e-maildir-shortcuts
      '(("/Inbox"                .?i)
        ("/[Gmail]/Sent Mail"    .?s)
        ("/[Gmail]/Trash"        .?t)
        ("/[Gmail]/Forums"        .?f)
        ("/[Gmail]/All Mail"     .?a)))

(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-user "dbeauchesne@gmail.com")
(setq smtpmail-local-domain "gmail.com")
(setq smtpmail-default-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-stream-type 'starttls))

(shell-command "setxkbmap -option ctrl:swapcaps")

(require 'exwm)
(require 'exwm-config)
(require 'exwm-systemtray)
(exwm-config-example)
(exwm-systemtray-enable)

(display-time-mode t)
(display-battery-mode t)
