#!/bin/bash

version="0.8.1"
url="https://github.com/prometheus/mysqld_exporter/releases/download/${version}/mysqld_exporter-${version}.linux-amd64.tar.gz"
PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
mkdir -p ${PROGRAM_PATH}
curl -Ls ${url} -o ${PROGRAM_PATH}/mysqld_exporter.tar.gz | tar --strip 1  -C ${PROGRAM_PATH} -xzvf -
chmod +x ${PROGRAM_PATH}/mysqld_exporter
rm ${PROGRAM_PATH}/mysqld_exporter.tar.gz
