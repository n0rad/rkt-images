#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

/usr/sbin/php-fpm
/usr/sbin/nginx -g "daemon on;"
while true; do
    su -m nobody -c "php /ttrss/update.php --feeds --quiet"
    sleep 900
done
