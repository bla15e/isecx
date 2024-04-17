(define-module (isecx-www)
  #:use-module (gnu system)
  #:use-module (ise machine)
  #:use-module (ise machine system)
  #:use-module (ise machine services)
  #:use-module (gnu machine ssh)
  #:export (os))

(define %website-services
  %base-docker-services)

(define* (os ssh-pub guix-pub)
  (operating-system
    (inherit (machine-system-for-services %website-services ssh-pub guix-pub))
    (host-name "isecx")))
