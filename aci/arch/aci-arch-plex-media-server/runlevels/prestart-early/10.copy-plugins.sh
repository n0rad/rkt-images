#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

rm -f '/var/lib/plex/Plex Media Server/plexmediaserver.pid'


mkdir -p '/var/lib/plex/Plex Media Server'
cp -R /plex-plugins/* '/var/lib/plex/Plex Media Server'
