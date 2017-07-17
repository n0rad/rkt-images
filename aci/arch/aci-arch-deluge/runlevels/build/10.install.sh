#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

su -c "yaourt -S deluge python2-mako python2-service-identity --noconfirm" yaourt
