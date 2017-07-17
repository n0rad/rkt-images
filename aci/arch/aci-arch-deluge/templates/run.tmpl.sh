#!/bin/bash
set -x

echo "Starting web ..."
deluge-web -f --loglevel=info -c /config
echo "Starting daemon ..."
deluged -d --loglevel=info -c /config
