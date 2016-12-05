#!/bin/bash

#url="https://github.com/nyodas/nginx_exporter/archive/master.tar.gz"
PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
mkdir -p ${PROGRAM_PATH}
#curl -L $url | tar -C /tmp --strip 1 -xzvf -
export GOPATH=/go
go get github.com/nyodas/nginx_exporter
cd /go/src/github.com/nyodas/nginx_exporter
go build
mv nginx_exporter ${PROGRAM_PATH}/nginx_exporter
chmod +x ${PROGRAM_PATH}/nginx_exporter
rm -rf /go
