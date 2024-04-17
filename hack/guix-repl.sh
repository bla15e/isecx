# [[file:../org/hack.org::*Guix TCP Repl][Guix TCP Repl:1]]
# [[file:hack.org::*Guix TCP Repl][hackscript-prefix]]
#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Set the $TRACE variable for debugging
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

cd "$(dirname "$0")"
cd "../"
# hackscript-prefix ends here
main() {
  tempfile=$(mktemp)
  cat << EOF > "$tempfile"
(use-modules (gnu packages))
(display "Loaded GNU Packages Module \n")
EOF
  echo "Starting Development Guix Repl listening on port tcp:37146"
  export INSIDE_EMACS=1
  guix repl --load-path=./channel-src --listen=tcp:37146 --interactive $tempfile    
}
main "$@"
# Guix TCP Repl:1 ends here
