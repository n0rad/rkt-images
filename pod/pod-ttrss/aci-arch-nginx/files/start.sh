#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

sleep 60
/usr/sbin/php-fpm
/usr/sbin/nginx
