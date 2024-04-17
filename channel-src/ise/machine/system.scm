;; [[file:../../../org/guix.org::defn-module-ise-deployed][defn-module-ise-deployed]]
(define-module (ise machine system)
  #:use-module (gnu)
  #:use-module (gnu system)

  #:use-module (ise machine services)

  #:export (machine-system-for-services))

(define* (machine-system-for-services services ssh-key guix-key
            #:key
            (ops-user "opsadmin")
            (locale "en_US.utf8")
            (timezone "Etc/UTC")
            (bootloader-target "/dev/sda")
            (root-fs-device "/dev/sda1"))
    (operating-system
      (host-name "give-me-a-hostname")
      (timezone timezone)
      (locale locale)

      (initrd-modules %vm-initrd-modules)
      (bootloader
       (bootloader-configuration
        (bootloader grub-bootloader)
        (targets (list bootloader-target))))
      (file-systems
       (cons* (file-system
                (device root-fs-device)
                (mount-point "/")
                (type "ext4"))
              %base-file-systems))
      (users
       (cons* (user-account
               (name ops-user)
               (comment ops-user)
               (home-directory (string-append "/home/" ops-user))
               (group "users")
               (supplementary-groups '("wheel" "docker")))
              %base-user-accounts))
      ;; ops-user needs to be able to use 'sudo' without password for 'guix deploy'
      (sudoers-file
       (plain-file
        "sudoers"
        (string-append (plain-file-content %sudoers-specification)
                       (format #f "~a ALL = NOPASSWD: ALL~%"
                               ops-user))))

      ;; Globally-installed packages.
      (packages (cons* nss-certs gnutls %base-packages))

      (services
       (append
        services
        (base-machine-services ssh-key guix-key)))))
;; defn-module-ise-deployed ends here
