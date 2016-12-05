#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

sleep 10 # wait for db
/opt/seafile-server-latest/seafile.sh start
sleep 10
/opt/seafile-server-latest/seahub.sh start-fastcgi

exit 0
