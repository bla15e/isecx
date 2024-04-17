+++
title = "Literate Programming: Tangle & Weave My Blog"
author = ["Blaise"]
summary = "Writing a post that is also a program"
date = 2024-04-03T21:09:28-04:00
tags = ["babel", "guix", "shell"]
draft = false
+++

Let us begin with a description of what tangling and weaving means in the context of literate programming. We wish for our program to be representable for two distinct audiences: a ****human**** audience and a ****compiler**** audience.

-   _Tangling_ produces literature for the ****human**** audience
-   _Weaving_ produces literature for the ****compiler**** audience


## Writing an Emacs Batch Program {#writing-an-emacs-batch-program}

To achieve this, we exploit org-babel-tangle and ox-hugo.

<a id="code-snippet--emacs-lit-fns"></a>
```emacs-lisp
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
```


## Shell Script {#shell-script}

To easily run this process in the CLI, we provide shell scripts.

<a id="code-snippet--tangle-main"></a>
```bash
# Tangling from the CLI
main() {
    find ./org/ -name "$1.org" -exec emacs -batch -l ./hack/config/emacs-lit.el --eval '(tangle "{}")' \;
}
```

<a id="code-snippet--weave-main"></a>
```bash
# Weaving from the CLI
main() {
    export HUGO_BASE_DIR=$(pwd)/site
    find ./org/ -name "$1.org" -exec emacs -batch -l ./hack/config/emacs-lit.el --eval '(weave "{}")' \;
}
```


## Future Work {#future-work}


### Watch Directory and tangle/weave on change {#watch-directory-and-tangle-weave-on-change}


### Include Tangled-Artifacts in our woven md {#include-tangled-artifacts-in-our-woven-md}
