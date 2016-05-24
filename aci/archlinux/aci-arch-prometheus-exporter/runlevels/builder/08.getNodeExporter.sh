#!/bin/bash

VERSION_NODE="0.12.0"


url_node_exporter="https://github.com/prometheus/node_exporter/releases/download/$VERSION_NODE/node_exporter-$VERSION_NODE.linux-amd64.tar.gz"

PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
mkdir -p ${PROGRAM_PATH}


curl -Ls ${url_node_exporter} | tar -C ${PROGRAM_PATH} --strip 1 -xzvf -
