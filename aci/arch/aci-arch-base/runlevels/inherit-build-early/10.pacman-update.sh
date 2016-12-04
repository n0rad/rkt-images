#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

pacman -Sy

# yaourt required it
if ! ls /dev/fd &> /dev/null; then
    ln -s /proc/self/fd /dev/fd
fi
