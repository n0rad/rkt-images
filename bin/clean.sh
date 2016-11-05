#!/bin/bash
set -x


if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

buildHome=$( dirname $0 )/..

for aci in $buildHome/aci/*; do
    cd $aci
    pwd
    ../../bin/dgr clean
    cd -
done

for pod in $buildHome/pod/*; do
    cd $pod
    ../../bin/dgr clean
    cd -
done
