#!/bin/bash

PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
mkdir -p ${PROGRAM_PATH}
export GOPATH=/go
go get github.com/wrouesnel/postgres_exporter
cd /go/src/github.com/wrouesnel/postgres_exporter
go build -o postgres_exporter .
mv postgres_exporter ${PROGRAM_PATH}/postgres_exporter
chmod +x ${PROGRAM_PATH}/postgres_exporter
rm -rf /go
