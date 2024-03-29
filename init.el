(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; disable scrollbar
(menu-bar-mode 1)    ; enable top menu list
(tool-bar-mode -1)   ; disable visual toolbar
(set-fringe-mode 10)

(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(setq package-enable-at-startup t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Init use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package all-the-icons)

(use-package vhdl-ext
  :hook ((vhdl-mode . vhdl-ext-mode))
  :init
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
  :config
  (vhdl-ext-mode-setup))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper )
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes)
(load-theme 'doom-dracula)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  )

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  
  (rune/leader-keys
    "t" '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :hook (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; Use visual line motions even outside of visual line buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(evil-collection evil general helpful ivy-rich which-key rainbow-delimiters doom-themes doom-modeline counsel ivy vhdl-ext all-the-icons))
 '(user-full-name "eChirp")
 '(user-mail-address "tmaintz91@gmail.com")
 '(vhdl-basic-offset 4)
 '(vhdl-clock-edge-condition 'function)
 '(vhdl-copyright-string
   "-------------------------------------------------------------------------------\12-- Copyright (c) <year> all rights reserved\12")
 '(vhdl-file-header
   "\12-------------------------------------------------------------------------------\12-- File : <filename>\12<projectdesc>-------------------------------------------------------------------------------\12-- Description: <cursor>\12<copyright>-------------------------------------------------------------------------------\12\12")
 '(vhdl-file-name-case 'downcase)
 '(vhdl-forbidden-words '("bit"))
 '(vhdl-highlight-forbidden-words t)
 '(vhdl-include-port-comments t)
 '(vhdl-indent-tabs-mode t)
 '(vhdl-intelligent-tab t)
 '(vhdl-modify-date-on-saving nil)
 '(vhdl-reset-active-high t)
 '(vhdl-reset-kind 'sync)
 '(vhdl-speedbar-auto-open t)
 '(vhdl-speedbar-display-mode 'project)
 '(vhdl-standard '(8 (math)))
 '(vhdl-stutter-mode t)
 '(vhdl-testbench-create-files 'separate)
 '(vhdl-testbench-declarations
   "signal slClk : std_logic := '1';\12signal slReset : std_logic := '0';\12")
 '(vhdl-testbench-initialize-signals t)
 '(vhdl-testbench-statements
   "\12  CreateClock(slClk, ktClkPeriod);\12  CreateReset()\12  \12")
 '(vhdl-underscore-is-part-of-word t)
 '(vhdl-upper-case-constants nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "#f00"))))
 '(vhdl-font-lock-function-face ((t (:foreground "Orchid1" :weight bold))))
 '(vhdl-font-lock-generic-/constant-face ((t (:foreground "BurlyWood1"))))
 '(vhdl-font-lock-translate-off-face ((t (:foreground "gray")))))
