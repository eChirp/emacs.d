; Use straight as package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'vhdl-ts-mode)

(straight-use-package 'vhdl-ext)
;; Can also be set through `M-x RET customize-group RET vhdl-ext':
;; Comment out/remove the ones you do not need
(setq vhdl-ext-feature-list
      '(font-lock
        xref
        capf
        hierarchy
        eglot
        lsp
        flycheck
        beautify
        navigation
        template
        compilation
        imenu
        which-func
        hideshow
        time-stamp
        ports))
(require 'vhdl-ext)
(vhdl-ext-mode-setup)
(add-hook 'vhdl-mode-hook #'vhdl-ext-mode)

(straight-use-package 'fpga)
(setq fpga-feature-list '(xilinx siemens))
(require 'fpga)
