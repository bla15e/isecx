# [[file:../org/hack.org::*Build Channel Locally][Build Channel Locally:1]]
# [[file:hack.org::*Build Channel Locally][hackscript-prefix]]
#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Set the $TRACE variable for debugging
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

original_working_dir=$(pwd)
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

  guix time-machine -C $tempfile --debug=5 --keep-failed -- "$@"
}
main "$@"
# Build Channel Locally:1 ends here
