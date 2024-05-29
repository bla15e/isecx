# [[file:../org/hack.org::ship-it-sh][ship-it-sh]]
# [[file:hack.org::ship-it-sh][hackscript-prefix]]
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
  rsync -av --delete --progress "$tempfile/" "$COPYUSER@$1:/var/www/$SITENAME"
}
main "$@"
# ship-it-sh ends here
