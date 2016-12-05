#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x



/usr/bin/certbot renew --quiet --agree-tos
/usr/sbin/nginx -g daemon off;
