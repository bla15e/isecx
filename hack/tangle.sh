# [[file:../org/hack.org::tangle-sh][tangle-sh]]
# [[file:hack.org::tangle-sh][hackscript-prefix]]
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
# [[file:hack.org::tangle-main][tangle-main]]
# Tangling from the CLI
main() {
    find ./org/ -name "$1.org" -exec emacs -batch -l ./hack/config/emacs-lit.el --eval '(tangle "{}")' \;
}
# tangle-main ends here
main "$@"
# tangle-sh ends here
