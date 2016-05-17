#!/bin/bash
set -x
set -e

cd /bin
wget https://raw.githubusercontent.com/blablacar/dgr/master/dgr-update.sh
chmod +x dgr-update.sh
./dgr-update.sh
