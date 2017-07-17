#!/bin/bash
set -x

echo "Starting daemon ..."
deluged -d --loglevel=info -c /deluge/config
echo "Starting web ..."
deluge-web --loglevel=info -c /deluge/config