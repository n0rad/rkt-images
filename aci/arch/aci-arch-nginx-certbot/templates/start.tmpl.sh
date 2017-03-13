#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

## Create certif
# certbot certonly --email email@example.com --webroot -w /var/lib/letsencrypt/ -d domain.tld,sub.domain.tld

mkdir -p /var/lib/letsencrypt/.well-known
chgrp http /var/lib/letsencrypt
chmod g+s /var/lib/letsencrypt

nginx -g "daemon on;"

while true; do
    # renew
    certbot renew --agree-tos
    # update nginx
    nginx -s reload
    sleep 86400 # 1d
done
