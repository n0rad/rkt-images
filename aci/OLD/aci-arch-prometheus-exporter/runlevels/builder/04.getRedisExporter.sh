#!/bin/bash
version="v0.4"
url="https://github.com/oliver006/redis_exporter/archive/${version}.tar.gz"
PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
mkdir -p ${PROGRAM_PATH}
ls -ls ${PROGRAM_PATH}
curl -L ${url} | tar -C /tmp --strip 1 -xzvf -
export GOPATH=/go
go get github.com/oliver006/redis_exporter
cd /go/src/github.com/oliver006/redis_exporter
go build
mv redis_exporter ${PROGRAM_PATH}/redis_exporter
chmod +x ${PROGRAM_PATH}/redis_exporter
rm -rf /go
