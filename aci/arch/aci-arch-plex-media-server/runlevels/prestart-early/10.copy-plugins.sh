#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

cp -R /plex-plugins/* '/var/lib/plex/Plex Media Server'
