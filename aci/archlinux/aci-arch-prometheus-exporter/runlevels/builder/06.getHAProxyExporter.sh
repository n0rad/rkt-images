#!/bin/bash

set -x
EXPORTER_VERSION=0.6.0
url="https://github.com/prometheus/haproxy_exporter/releases/download/${EXPORTER_VERSION}/haproxy_exporter-${EXPORTER_VERSION}.linux-amd64.tar.gz"
PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
mkdir -p ${PROGRAM_PATH}
curl -Ls ${url} | tar --strip 1 -C ${PROGRAM_PATH} -xzvf -
chmod +x ${PROGRAM_PATH}/haproxy_exporter
