;; [[file:../../org/hack.org::emacs-lit-el][emacs-lit-el]]
;; [[file:hack.org::emacs-lit-prefix][emacs-lit-prefix]]
;; Quiets messages about shell indentation
(advice-add 'sh-set-shell :around
            (lambda (orig-fun &rest args)
              (cl-letf (((symbol-function 'message) #'ignore))
                (apply orig-fun args))))
;; emacs-lit-prefix ends here
;; [[file:hack.org::emacs-lit-fns][emacs-lit-fns]]
;; Enable Org mode
(use-package org)
;; Extend org-export to support hugo flavored markdown
(use-package ox-hugo
    :after ox)
(defun tangle (file-path)
  "Open FILE-PATH in current buffer and tangle its contents, producing compiler literature"
  (with-current-buffer (find-file file-path)
    (org-mode)
    ;; If you want to do any additional processing of the buffer contents,
    ;; you can do it here before exporting.
    (org-babel-tangle)))

(defun weave (file-path)
  "Open FILE-PATH in current buffer and weave its contents, producing human literature"
  (setq 
    org-hugo-base-dir (getenv "HUGO_BASE_DIR")
    org-babel-tangle-mode 'read-only)

  (with-current-buffer (find-file file-path)
    (org-mode)
    ;; If you want to do any additional processing of the buffer contents,
    ;; you can do it here before exporting.
    (org-hugo-export-wim-to-md :all-subtrees nil nil nil)))
;; emacs-lit-fns ends here
;; emacs-lit-el ends here
