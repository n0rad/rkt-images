#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

su -c "yaourt -S bind --noconfirm" yaourt
