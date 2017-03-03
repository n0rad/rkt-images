#!/bin/bash
set -x


if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

buildHome=$( dirname $0 )/..

for aci in ${buildHome}/aci/none/*; do
    echo ${aci}
    dgr -W ${aci} clean
done

for aci in ${buildHome}/aci/arch/*; do
    echo ${aci}
    dgr -W ${aci} clean
done

for pod in ${buildHome}/pod/*; do
    echo ${pod}
    dgr -W ${pod} clean
done
