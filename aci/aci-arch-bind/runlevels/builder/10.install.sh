#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# required to finish postinstall bind stuff
pacman -S systemd --noconfirm

pacman -S  bind --noconfirm
