#!/bin/bash
set -x



hash=$(echo -n "{{.amule.server.password}}" | md5sum | cut -d ' ' -f 1)
if [ ! -f /config/amule.conf ]; then
echo "writting server password"
    cat >/config/amule.conf <<EOL
[ExternalConnect]
AcceptExternalConnections=1
ECPassword=${hash}
EOL
fi

echo "writting web interface passwords"
sudo -u amule amuleweb --write-config --password="{{.amule.server.password}}" --admin-pass="{{.amule.client.password}}"

echo "Starting server ..."
sudo -u amule amuled -f -c /config

sleep 30

echo "Starting web ..."
sudo -u amule amuleweb > /dev/null 2>&1
