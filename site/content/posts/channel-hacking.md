+++
title = "Scripts for Guix Channel Hacking :babel:guix:shell"
author = ["Blaise"]
summary = "Useful shell scripts"
date = 2024-04-03T21:09:28-04:00
draft = false
+++

Guix Channels are a powerful means for distributing software. Here, I have implemented some simple shell scripts that will enhance the development experience. These include

-   Building the channel without guix pull
-   Testing a package definition in a shell
-   Refreshing your home-env


## Build Channel Locally {#build-channel-locally}

```shell
# [[file:hack.org::hackscript-prefix][hackscript-prefix]]
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
(list
  (channel
    (name 'isecx)
    (url "file://$(pwd)")
    (branch "$(git rev-parse --abbrev-ref HEAD)")))
EOF

  guix time-machine -C $tempfile --debug=3 --keep-failed -- shell hello
}
main "$@"
```


## Home Refresh {#home-refresh}


## Guix TCP Repl {#guix-tcp-repl}

Launches a guix rpel configured to listen on a TCP port. Can be 'jacked-in' through an IDE integration. In the case of emacs, this is `geiser-connect`
Notice that I 'used' the (gnu packages) module. This allows programs sent to the repl to be able to use the various modules we have defined in our guix channel dependencies.

```shell
# [[file:hack.org][hackscript-prefix]]
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
```


## Package Shell {#package-shell}


## Future Work {#future-work}


### <span class="org-todo todo TODO">TODO</span> Implement Scripts {#implement-scripts}
