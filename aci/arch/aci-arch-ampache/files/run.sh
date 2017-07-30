#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

mkdir -p /run/php-fpm
/usr/sbin/php-fpm
/usr/sbin/nginx -g "daemon off;"
