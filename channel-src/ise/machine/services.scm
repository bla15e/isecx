(define-module (ise machine services)
  #:use-module (gnu)
  #:use-module (gnu system)

  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:use-module (gnu services dbus)
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu services ssh)
  #:export (base-machine-services))

(define %vm-initrd-modules
  (cons* "virtio_scsi"
         %base-initrd-modules))

(define* (ssh-configuration-for-keys ssh-authorized-keys)
  (openssh-configuration
   (openssh openssh-sans-x)
   (permit-root-login 'prohibit-password)
   (password-authentication? #f)
   (authorized-keys ssh-authorized-keys)))
(define* (base-machine-services ssh-key-deploy guix-substitute-keys
                                #:key
                                (ssh-authorized-keys `())
                                (ssh-deploy-user "root")
                                (base-services %base-services))
  (cons*
   (service openssh-service-type
            (ssh-configuration-for-keys
             (cons*
              `(,ssh-deploy-user ,ssh-key-deploy)
              `("root" ,ssh-key-deploy)
              ssh-authorized-keys)))
   (modify-services base-services
     (guix-service-type
      config =>
      (guix-configuration
       (inherit config)
       (authorized-keys
        (append
         guix-substitute-keys
         (guix-configuration-authorized-keys config))))))))

(define %base-docker-services
  (cons*
   (service docker-service-type)
   (service dbus-root-service-type)
   (service elogind-service-type)
   %base-services))
