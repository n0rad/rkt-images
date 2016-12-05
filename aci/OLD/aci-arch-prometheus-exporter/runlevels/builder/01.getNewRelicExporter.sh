#!/dgr/bin/busybox sh
# - http://prometheus.io/docs/instrumenting/exporters/
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

VERSION="0.16.1"

url_newrelic_exporter="https://raw.githubusercontent.com/nyodas/prometheus_exporter/master/newrelic_exporter.tar.gz"
url_newrelic_exporter_lib="https://github.com/nyodas/prometheus_exporter/raw/master/linux-lib.tar.gz"

PROGRAM_PATH="$ROOTFS/etc/prometheus/exporter"
mkdir -p ${PROGRAM_PATH}

curl -Ls ${url_newrelic_exporter} | tar -C ${PROGRAM_PATH} -xzvf -
#curl -Ls ${url_newrelic_exporter_lib} | tar -C ${ROOTFS} -xzvf -
