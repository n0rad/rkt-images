#!/bin/bash
set -e
source /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

cp /var/named/* /var/lib/bind/
chown -R named: /var/lib/bind/