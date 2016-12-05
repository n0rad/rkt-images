#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

su -c "yaourt -S  python2-mako --noconfirm" yaourt
su -c "yaourt -S  python2-service-identity --noconfirm" yaourt