#!/bin/bash
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

sudo -u libresonic /var/lib/libresonic/libresonic.sh

while true; do sleep 1000000; done
