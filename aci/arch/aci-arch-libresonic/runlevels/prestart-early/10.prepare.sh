#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

rm -f /var/lib/libresonic/libresonic.war
rm -f /var/lib/libresonic/libresonic.sh
rm -f /var/lib/libresonic/libresonic.service

ln -s /libresonic/libresonic.war /var/lib/libresonic
ln -s /libresonic/libresonic.sh /var/lib/libresonic
ln -s /libresonic/libresonic.service /var/lib/libresonic

chown libresonic: /var/lib/libresonic
