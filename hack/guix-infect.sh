# [[file:../org/hack.org::*guix-infect.sh][guix-infect.sh:1]]
# [[file:hack.org::hackscript-prefix][hackscript-prefix]]
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
    echo "Infecting $1 to configure System $2"
    ssh root@$1 "mkdir -p /etc/guix-infect"
    scp ./hack/guix-infect/debian-11.sh root@$1:/etc/guix-infect/setup.sh
    cd $original_working_dir
    scp $2 root@$1:/etc/guix-infect/configuration.scm
    ssh root@$1 "chmod +x /etc/guix-infect/setup.sh"
}
main "$@"
# guix-infect.sh:1 ends here
