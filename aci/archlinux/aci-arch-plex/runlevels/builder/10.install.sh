#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

pacman --root=/  -Syu libelf paxtest --noconfirm
export PATH=$PATH:${ROOTFS}/usr/bin

su -c 'yaourt -yyS plex-media-server --noconfirm' yaourt
