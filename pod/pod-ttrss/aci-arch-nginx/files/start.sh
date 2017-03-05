#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

/usr/sbin/nginx
/usr/sbin/php-fpm -F
