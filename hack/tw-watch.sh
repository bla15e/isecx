# [[file:../org/hack.org::tw-watch-sh][tw-watch-sh]]
# [[file:hack.org::tw-watch-sh][hackscript-prefix]]
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
  npx tailwindcss -i ./site/themes/ap-lit/assets/css/main.css -o ./site/themes/ap-lit/assets/css/tailwind-output.css --watch
}
main "$@"
# tw-watch-sh ends here
