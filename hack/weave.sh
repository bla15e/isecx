# [[file:../org/hack.org::weave-sh][weave-sh]]
# [[file:hack.org::weave-sh][hackscript-prefix]]
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
# [[file:hack.org::weave-main][weave-main]]
# Weaving from the CLI
main() {
    export HUGO_BASE_DIR=$(pwd)/site
    find ./org/ -name "$1.org" -exec emacs -batch -l ./hack/config/emacs-lit.el --eval '(weave "{}")' \;
}
# weave-main ends here
main "$@"
# weave-sh ends here
