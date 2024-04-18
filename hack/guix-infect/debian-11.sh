#!/bin/bash

set -o errexit
set -o pipefail
# Test on:
# - Debian 11
#
# 1. Create a new CCX11 with Debian 11
# 2. Login with SSH
# 3. Paste this script into a setup.sh and run it
# 4. Wait for the script to complete

###### MODIFY

TIMEZONE="Etc/UTC"
LOCALE="en_US.utf8"

###### MODIFY END
GUIX_DAEMON_SYSTEMD_SERVICE=/etc/systemd/system/guix-daemon.service
BORDEAUX_SIGNING_KEY=~root/.config/guix/current/share/guix/bordeaux.guix.gnu.org.pub
CONFIG=/etc/guix-infect/configuration.scm
CHANNELS=/etc/guix/channels.scm

function main() {
  echo "Preparing System"
  install_xz_utils
  install_guix_from_internet
  install_root_user_guix_config
  install_guix_info_files
  install_guix_binary

  add_guixbuild_group_and_users
  install_and_start_systemd_daemon


  echo "Setting up Guix binaries"
  write_substitute_server_signing_key
  echo "Writing Channels"
  write_system_channels
  echo "Pulling Latest Guix Revision & Channels"
  guix_authorize_and_pull_noauth
  guix_setup_locale
  echo "Installing openssl and certs"
  guix_install_openssl
  echo "Building Guix"
  guix_system_build_bootstrap
  echo "Configuring Guix"
  guix_system_configure_bootstrap
}

function install_xz_utils() {
  apt-get update -y
  apt-get install curl xz-utils -y
}

function install_guix_from_internet() {
  wget https://ftp.gnu.org/gnu/guix/guix-binary-1.4.0.x86_64-linux.tar.xz
  cd /tmp
  tar --warning=no-timestamp -xf ~/guix-binary-1.4.0.x86_64-linux.tar.xz
  mv var/guix /var/ && mv gnu /
}

function add_guixbuild_group_and_users() {
  groupadd --system guixbuild
  for i in `seq -w 1 10`;
  do
    useradd -g guixbuild -G guixbuild         \
      -d /var/empty -s `which nologin`  \
      -c "Guix build user $i" --system  \
      guixbuilder$i;
  done;
}

function install_root_user_guix_config() {
  mkdir -p ~root/.config/guix
  ln -sf /var/guix/profiles/per-user/root/current-guix ~root/.config/guix/current
  export GUIX_PROFILE="`echo ~root`/.config/guix/current" ;
  source $GUIX_PROFILE/etc/profile
}

function install_and_start_systemd_daemon() {
  cp ~root/.config/guix/current/lib/systemd/system/guix-daemon.service /etc/systemd/system/
  # start guix systemd daemon
  echo "starting guix-daemon"
  systemctl start guix-daemon && systemctl enable guix-daemon
}

function write_systemd_daemon() {
  cat >> $GUIX_DAEMON_SYSTEMD_SERVICE <<EOL
# This is a "service unit file" for the systemd init system to launch
# 'guix-daemon'.  Drop it in /etc/systemd/system or similar to have
# 'guix-daemon' automatically started.

[Unit]
Description=Build daemon for GNU Guix

[Service]
ExecStart=/var/guix/profiles/per-user/root/current-guix/bin/guix-daemon --build-users-group=guixbuild
Environment='GUIX_LOCPATH=/var/guix/profiles/per-user/root/guix-profile/lib/locale' LC_ALL=en_US.utf8/
RemainAfterExit=yes
StandardOutput=syslog
StandardError=syslog

# See <https://lists.gnu.org/archive/html/guix-devel/2016-04/msg00608.html>.
# Some package builds (for example, go@1.8.1) may require even more than
# 1024 tasks.
TasksMax=8192

[Install]
WantedBy=multi-user.target
EOL
}

function install_guix_info_files() {
  mkdir -p /usr/local/share/info
  cd /usr/local/share/info
  for i in /var/guix/profiles/per-user/root/current-guix/share/info/*; do
    ln -s $i; done
}

function install_guix_binary() {
  # Install binary
  mkdir -p /usr/local/bin
  cd /usr/local/bin
  ln -s /var/guix/profiles/per-user/root/current-guix/bin/guix
}

function write_substitute_server_signing_key() {
  # For now we'll use Bordeaux, but later on let's try to switch to our own subsitute server
    # substitutes,guixhub.com
    echo "Doing Nothing to write the substitute server signing key lol"
}

function guix_authorize_and_pull_noauth() {
  # Replace this with bourdeaux ssigning key I believe
  guix archive --authorize < ~root/.config/guix/current/share/guix/bordeaux.guix.gnu.org.pub
  guix archive --authorize < ~root/.config/guix/current/share/guix/ci.guix.gnu.org.pub
  # Why did they comment out the guix pull? it's pretty friggen important if you ask me
  guix pull -k --verbosity=3

  hash guix
}

function guix_setup_locale() {
  guix package -i glibc-utf8-locales-2.29
  export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
}

function guix_install_openssl() {
  guix package -i nss-certs gnutls
}

function write_ssh_pub_keys() {
  echo "writing SSH pubs keys you specified"
}

function write_system_channels() {
  # TODO Replace with file template
  mkdir -p "$(dirname $CHANNELS)"
  cat >> $CHANNELS <<EOL
;; ISE Default Channel
(list
      (channel
        (name 'isecx)
        (url "https://github.com/bla15e/isecx")
        (branch "main")))
EOL
}

function guix_system_build_bootstrap() {
  echo "Building Bootstrap"
  # guix system build /etc/bootstrap-config.scm
}

function guix_system_configure_bootstrap() {
    rm -rf /etc/pam.d /etc/ssl /etc/udev
    mv /etc /old-etc
    mkdir /etc
    cp -r /old-etc/{passwd,group,resolv.conf,services,shadow,gshadow,mtab,guix,guix-infect} /etc/

    echo "Configuring System"
    guix system reconfigure $CONFIG

    echo "Rebooting the system..."
    reboot
}


main
