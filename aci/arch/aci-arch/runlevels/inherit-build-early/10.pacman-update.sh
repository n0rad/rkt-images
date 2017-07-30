#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# update packages
pacman -Syu --noconfirm

# update keyring
#pacman-key --refresh-keys || true

# yaourt required it
if ! ls /dev/fd &> /dev/null; then
    ln -s /proc/self/fd /dev/fd
fi
