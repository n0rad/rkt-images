#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

cp /config/*.dist /usr/share/webapps/ampache/config/

#ln -s /ampache /srv/http
