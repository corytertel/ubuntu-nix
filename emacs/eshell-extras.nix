{ config, pkgs }:

let

  foreground      = "#141404";
  background      = "#ffffff";
  background-alt1 = "#eeeeee";
  background-alt2 = "#e8e8e8";
  background-alt3 = "#dddddd";
  background-alt4 = "#cccccc";
  color0          = "#141404";
  color8          = "#141404";
  color1          = "#e60909";
  color9          = "#e60909";
  color2          = "#1f8c35";
  color10         = "#1f8c35";
  color3          = "#ed8f23";
  color11         = "#ed8f23";
  color4          = "#3647d9";
  color12         = "#3647d9";
  color5          = "#e01bd0";
  color13         = "#e01bd0";
  color6          = "#2d9574";
  color14         = "#2d9574";
  color7          = "#ffffff";
  color15         = "#ffffff";

in ''
;; Eshell prompt
(use-package eshell-prompt-extras
  :config
  (defun epe-theme-cory ()
    "Cory's prompt."
    ;; If the prompt spans over multiple lines, the regexp should match
    ;; last line only.
    (setq eshell-prompt-regexp "^╰─λ ")
    (concat
     (epe-colorize-with-face (epe-status) 'epe-status-face)
     (when (epe-remote-p)
       (epe-colorize-with-face
	(concat "(" (epe-remote-user) "@" (epe-remote-host) ")")
	'epe-remote-face))
     (when (and epe-show-python-info (bound-and-true-p venv-current-name))
       (epe-colorize-with-face (concat "(" venv-current-name ") ") 'epe-venv-face))
     (let ((f (cond ((eq epe-path-style 'fish) 'epe-fish-path)
                    ((eq epe-path-style 'single) 'epe-abbrev-dir-name)
                    ((eq epe-path-style 'full) 'abbreviate-file-name))))
       (pcase (epe-extract-git-component (funcall f (eshell/pwd)))
	 (`(,prefix nil)
          (format
           (propertize "╭╴%s %s" 'face '(:weight regular))
           (propertize "" 'face '(:weight bold :foreground "${color6}"))
           (propertize prefix 'face '(:weight bold :foreground "${color4}"))))
	 (`(,prefix ,git-component)
          (format
           (epe-colorize-with-face "╭╴%s %s%s %s %s" '(:weight regular))
	   (epe-colorize-with-face "" '(:weight bold :foreground "${color6}"))
           (epe-colorize-with-face prefix '(:weight bold :foreground "${color4}"))
           (if (string-empty-p git-component)
               ""
             (concat "/"
                     (epe-colorize-with-face git-component '(:weight bold :foreground "${color6}"))))
           (epe-colorize-with-face
            (concat (or (epe-git-branch)
                       (epe-git-tag))
                    (epe-git-dirty)
                    (epe-git-untracked))
            '(:weight italic :foreground "${color2}"))
	   (epe-colorize-with-face
	    (let ((unpushed (epe-git-unpushed-number)))
                      (if (= unpushed 0) ""
			(concat "↑" (number-to-string unpushed))))
	    '(:foreground "${color5}"))))))
     (epe-colorize-with-face "\n╰─λ" '(:weight regular))
     " "))
  (with-eval-after-load "esh-opt"
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-cory)))

;; Eshell undistract me
;; (use-package eshell-undistract-me
;;   :config
;;   (setq eshell-undistract-me-play-sound t)
;;   (setq eshell-undistract-me-sound-path "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/complete.oga")
;;   (add-hook 'eshell-pre-command-hook #'eshell-undistract-me-pre-command)
;;   (add-hook 'eshell-before-prompt-hook #'eshell-undistract-me-before-prompt))

(setq eshell-undistract-me-play-sound t)
(setq eshell-undistract-me-sound-path "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/complete.oga")
(add-hook 'eshell-pre-command-hook #'eshell-undistract-me-pre-command)
(add-hook 'eshell-before-prompt-hook #'eshell-undistract-me-before-prompt)
''
