#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

rm -Rf ${ROOTFS}/var/lib/pacman/sync/*
