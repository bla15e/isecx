(define-module (ise packages binary)
  #:use-module (guix packages)
  #:use-module ((guix licenses)  #:prefix license:)
  #:use-module (guix download)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages compression)
  #:use-module (isecx build-system binary))

(define-public go-github-com-gohugoio-hugo
    (package 
     (name "go-github-com-gohugoio-hugo")
     (version "0.120.4")
     (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/gohugoio/hugo/releases/download/v"
                                  version "/hugo_" version "_Linux-64bit.tar.gz"))
              (sha256
               (base32 "00vasi09dswyi8cv5axlw8scll3miamy0m1lsb935465ldgp77c4"))))
     (build-system binary-build-system)
     (arguments '(#:install-plan
                  '(("hugo" "bin/"))))
     (home-page "https://github.com/gohugoio/hugo")
     (synopsis "Hugo")
     (description
      "This package provides a Fast and Flexible Static Site Generator built with love
  by @url{https://github.com/bep,bep}, @url{http://spf13.com/,spf13} and
  @url{https://github.com/gohugoio/hugo/graphs/contributors,friends} in
  @url{https://golang.org/,Go}.")
     (license license:asl2.0)))

  (define-public go-github-com-gohugoio-hugo-extended
    (package
     (name "go-github-com-gohugoio-hugo-extended")
     (version "0.120.4")
     (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/gohugoio/hugo/releases/download/v"
                                  version "/hugo_extended_" version "_Linux-64bit.tar.gz"))
              (sha256
               (base32
                "11dqilvryn73v4j3g9ljfnr5awjpdxk7z3zqckq6rp2hy0cl14jg"))))
     (build-system binary-build-system)
     (arguments '(#:install-plan
                  '(("hugo" "bin/"))
                  #:patchelf-plan
                  `(("hugo" ("gcc")))
                  #:strip-binaries? #f))
     (inputs
      `((,gcc "lib")))
     (home-page "https://github.com/gohugoio/hugo")
     (synopsis "Hugo")
     (description
      "This package provides a Fast and Flexible Static Site Generator built with love
  by @url{https://github.com/bep,bep}, @url{http://spf13.com/,spf13} and
  @url{https://github.com/gohugoio/hugo/graphs/contributors,friends} in
  @url{https://golang.org/,Go}.")
     (license license:asl2.0)))

  (define-public lazydocker
    (package
      (name "lazydocker")
      (version "0.23.1")
      (source (origin
               (method url-fetch)
               (uri (string-append "https://github.com/jesseduffield/lazydocker/releases/download/v"
                                   version "/lazydocker_" version "_Linux_x86_64.tar.gz" ))
               (sha256
                (base32 "0flxmam71k8yc7pw6nxygc9ml5x8cvc6bpylplbs9rxm1qsz2ncp"))))
      (build-system binary-build-system)
      (supported-systems '("x86_64-linux"))
      (arguments
       `(#:install-plan '(("lazydocker" "bin/"))))
      (synopsis "A simple terminal UI for both docker and docker-compose")
      (description "Docker TUI")
      (home-page "https://github.com/jesseduffield/lazydocker")
      (license license:epl1.0)))
