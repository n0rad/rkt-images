#!/bin/bash

url="https://github.com/kbudde/rabbitmq_exporter/releases/download/pre-release/linux_amd64_rabbitmq_exporter"
PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
mkdir -p ${PROGRAM_PATH}
curl -Ls ${url} -o ${PROGRAM_PATH}/rabbitmq_exporter
chmod +x ${PROGRAM_PATH}/rabbitmq_exporter
