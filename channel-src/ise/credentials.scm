;; [[file:../../org/guix.org::ise-credentials-scm][ise-credentials-scm]]
;; [[file:guix.org::defn-module-ise-credentials][defn-module-ise-credentials]]
(define-module (ise credentials)
  #:use-module (guix gexp)
  #:export (guix-ed25519-public-key-file
            ssh-public-key-file))

(define* (guix-ed25519-public-key-file name q-param)
  (plain-file (format #f  "~a-guix-ed25519-substitute.pub" name)
              (format #f "(public-key
  (ecc
  (curve Ed25519)
  (q ~a)))" q-param)))

(define* (ssh-public-key-file name pub-key)
  (plain-file (format #f "~a-ssh-key.pub" name)
              pub-key))
;; defn-module-ise-credentials ends here
;; ise-credentials-scm ends here
