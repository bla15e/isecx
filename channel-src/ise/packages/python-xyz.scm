(define-module (ise packages python-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-compression)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix hg-download)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26))

(define-public python-terminaltexteffects
  (package
    (name "python-terminaltexteffects")
    (version "0.10.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "terminaltexteffects" version))
       (sha256
        (base32 "0srw45wfrbqm69jszd1yznypzpaa0ab7fl3jv50xdcwlw3h3lfzh"))))
    (build-system pyproject-build-system)
    (home-page null)
    (synopsis
     "A collection of visual effects that can be applied to terminal piped stdin text.")
    (description
     "This package provides a collection of visual effects that can be applied to
terminal piped stdin text.")
    (license license:expat)))

(define-public python-jinja2-cli-latest
  (package
    (name "python-jinja2-cli")
    (version "0.8.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "jinja2-cli" version))
        (sha256
          (base32
	   "0l4fw5wn3kxq5gvpi4wj76hvbxfyij9rb32ndwh8w4hi852v2sx1"))))
    (build-system python-build-system)
    (propagated-inputs
      (list python-jinja2))
    (native-inputs
      (list python-flake8 python-jinja2 python-pytest))
    (home-page "https://github.com/mattrobenolt/jinja2-cli")
    (synopsis "Command-line interface to Jinja2")
    (description
     "This package provides a command-line interface (CLI) to the Jinja2
template engine.")
    (license license:bsd-3)))

python-jinja2-cli-latest
