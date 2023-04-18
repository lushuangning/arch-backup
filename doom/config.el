;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(setq evil-default-state 'emacs)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Lu Shuangning"
      user-mail-address "sdyglsn@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "WenQuanYi Micro Hei Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "WenQuanYi Micro Hei Mono" :size 16)
      doom-big-font (font-spec :family "WenQuanYi Micro Hei Mono" :size 28))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-ayu-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq auto-save-visited-interval 10)
(auto-save-visited-mode +1)

(setq x-select-enable-clipboard t)

(use-package! eaf
  :load-path "~/.config/emacs/.local/straight/repos/emacs-application-framework"
  :init
  ;;:custom
  ;; 设定emacs中打开链接默认使用eaf打开
  ;;(browse-url-browser-function 'eaf-open-browser)
  ;; 设定eaf默认搜索引擎
  ;; (eaf-browser-default-search-engine "google")
  ;; 设定eaf开启广告屏蔽器
  ;;(eaf-browser-enable-adblocker t)
  :config
  (defalias 'browse-web #'eaf-open-browser)
  ;; 下面的require都是引入你已经安装的eaf扩展
  (require 'eaf)
  (require 'eaf-image-viewer)
  (require 'eaf-demo)
  (require 'eaf-browser)
  (require 'eaf-pdf-viewer)
  (require 'eaf-jupyter)
  (require 'eaf-video-player)
  (require 'eaf-music-player)
  (require 'eaf-org-previewer)
  (require 'eaf-org)
  (require 'eaf-mindmap)
)

;;(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha . 90))
