# [[file:../org/hack.org::ship-site-to-sh][ship-site-to-sh]]
# [[file:hack.org::ship-site-to-sh][hackscript-prefix]]
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

COPYUSER=root
SITENAME="ise.cx"
main() {
  tempfile=$(mktemp -d)
  hugo --destination "$tempfile" --source "./site/"
  echo "Copying Site '$SITENAME' with $COPYUSER@$1"
  rsync -av --delete --progress "$tempfile/" "$COPYUSER@$1:/var/www/html/$SITENAME"
}
main "$@"
# ship-site-to-sh ends here
