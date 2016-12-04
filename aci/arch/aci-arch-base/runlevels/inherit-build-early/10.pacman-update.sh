#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

pacman -Sy

# yaourt required it
if ! ls /dev/fd; then
    ln -s /proc/self/fd /dev/fd
fi
