#!/bin/bash
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

while [ ! -d /seafile/ccnet ]; do
  echo "Seafile is not initialized. Waiting"
  sleep 20
done

while [ ! -f /seafile/ok ]; do
  echo "Seafile is not ok."
  sleep 20
done

sleep 40
echo "Starting seafile"
#/seafile/seafile-server-latest/seafile.sh start # data as root
su seafile /seafile/seafile-server-latest/seafile.sh start # data as seafile
sleep 20
echo "Starting seahub"
/seafile/seafile-server-latest/seahub.sh start-fastcgi

echo "Starting gc cron"
crond

echo "Starting nginx"
/usr/sbin/nginx -g "daemon off;"
