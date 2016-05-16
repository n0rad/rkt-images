#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

pacman -S filesystem glibc coreutils grep less vi sed awk --noconfirm
