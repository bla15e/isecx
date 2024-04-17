(define-module (ise machine)
  #:use-module (gnu machine)
  #:use-module (gnu machine ssh))

(define* (ssh-machine deploy-to-host os
                      #:key
                      (deploy-user "root")
                      (ssh-identity "~/.ssh/id-guix-rsa"))
  (machine
   (operating-system os)
   (environment managed-host-environment-type)
   (configuration (machine-ssh-configuration
                   (host-name deploy-to-host)	  
                   (system "x86_64-linux")
                   (user deploy-user)
                   (identity ssh-identity)))))
