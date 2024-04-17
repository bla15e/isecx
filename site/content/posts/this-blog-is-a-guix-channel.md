+++
title = "This Blog is a Guix Channel :babel:guix:scheme"
author = ["Blaise"]
summary = "Combining the expressive power of an internet blog with the disribution mechanics of a guix channel."
date = 2024-04-03T21:09:28-04:00
draft = false
+++

GNU Guix is a state-of-the-art functional package manager. It enables users to develop and distribute software through powerful functional interfaces. A user of GNU Guix can specify a list of repository to subscribe to, and those repositories will be used to extend their Guix installation. A key takeway is that this website is impleneted as a git repository. Here, I will implement a set of programs enabling our git repository to serve as a GNU Guix Channel.


## Guix Channel Metadata - The .guix-channel file {#guix-channel-metadata-the-dot-guix-channel-file}

We provide a scheme program that returns a data structure describing the metadata that guix expects a channel to have. This metadata is expected to be contained in the file `.guix-channel` at the repository root.

<a id="code-snippet--guix-channel"></a>
```scheme
;; -*- mode: scheme; -*-

(channel
  (version 0)
  (directory "channel-src")
  (url "https://gitlab.com/ise-company/isecx")
  ;; Note that channel names here must be without quotes for the
  ;; dependencies to match up.  see https://issues.guix.gnu.org/53657
  (dependencies
    (channel
      (name guix)
      (url "https://git.savannah.gnu.org/git/guix.git")
      (commit "51de844a0ff6ea224367a384092896bce6848b9f")
      (channel-introduction
        (commit "9edb3f66fd807b096b48283debdcddccfea34bad")
        (signer "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
```


## Guix Goodies {#guix-goodies}

Guix allows us to describe how to reproduce our software through functional interfaces. I will be implementing a series of simple programs that will bring harmony to hacking on my website.


### Package Manifests {#package-manifests}

Packages are essential to GNU Guix. They describe software that can deployed through Guix. A manifest is a list of these packages. Using the standard libraries provided by GNU Guix, I have implemented a manifest describing the development inputs of this website.

<a id="code-snippet--manifest-scm"></a>
```scheme
(specifications->manifest
  (list
    "go-github-com-gohugoio-hugo-extended"
    "entr"
    "node"))
```


## Future Work {#future-work}


### <span class="org-todo todo TODO">TODO</span> Implement Channel Authentication {#implement-channel-authentication}
