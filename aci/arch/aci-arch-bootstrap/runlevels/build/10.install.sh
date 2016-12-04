#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

/usr/bin/haveged
pacman-key --init

