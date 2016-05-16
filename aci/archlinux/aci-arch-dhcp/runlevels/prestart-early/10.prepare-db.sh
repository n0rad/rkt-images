#!/bin/bash
set -e
source /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

if [ ! -f /var/lib/dhcp/dhcpd.leases ]; then
    touch /var/lib/dhcp/dhcpd.leases
fi
