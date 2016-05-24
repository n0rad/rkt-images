#!/bin/bash

VERSION_ES="0.3.0"

PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
url_es_exporter="https://github.com/ewr/elasticsearch_exporter/releases/download/${VERSION_ES}/elasticsearch_exporter-${VERSION_ES}.linux-amd64.tar.gz"

mkdir -p ${PROGRAM_PATH}

curl -Ls ${url_es_exporter} | tar -C ${PROGRAM_PATH} -xzvf -
