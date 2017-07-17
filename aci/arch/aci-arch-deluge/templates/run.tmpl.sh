#!/bin/bash
set -x

echo "Starting daemon ..."
deluged -d --loglevel=info -c /config
echo "Starting web ..."
deluge-web --loglevel=info -c /config