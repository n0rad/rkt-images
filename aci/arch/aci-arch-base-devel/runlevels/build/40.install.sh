#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x


pacman -S base-devel git --noconfirm

