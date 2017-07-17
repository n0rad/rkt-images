#!/bin/bash
set -x

echo "writting web interface password"
amuleweb --write-config --admin-pass="{{.amule.client.password}}"

echo "writting daemon"
/amuled.sh &

sleep 2

echo "Starting web ..."
/amuleweb.sh
