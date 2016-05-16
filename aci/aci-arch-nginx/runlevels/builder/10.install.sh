#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# nproc
pacman -S coreutils --noconfirm

pacman -S nginx --noconfirm
