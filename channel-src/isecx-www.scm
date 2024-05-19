(define-module (isecx-www)
  #:use-module (gnu packages)
  #:use-module (gnu system)
  #:use-module (ise machine)
  #:use-module (ise machine system)
  #:use-module (ise machine services)
  #:use-module (gnu machine ssh)
  #:export (os))

(define %website-services
  %base-docker-services)

(define* (os ssh-pub guix-pub)
  (let* ((base-os (machine-system-for-services %website-services ssh-pub guix-pub)))
    (operating-system
      (inherit base-os)
      (host-name "isecx")
      (packages (cons*
                 (specification->package "rsync")
                 (operating-system-packages base-os))))))
