#!/bin/bash
set -x

#if [ "$(id -u)" != "0" ]; then
#	echo "Sorry, you are not root."
#	exit 1
#fi

command -v gvmerge >/dev/null 2>&1 || { echo >&2 "I require graphviz but it's not installed.  Aborting."; exit 1; }

buildHome=$( dirname $0 )

for aci in $buildHome/aci/*/*; do
    cd $aci
    pwd
    sudo dgr graph
    cd -
done

for pod in $buildHome/pod/*; do
    cd $pod
    sudo dgr graph
    cd -
done

dots=$(ls $buildHome/aci/*/*/target/graph.dot $buildHome/pod/*/target/graph.dot)

mkdir -p ${buildHome}/target

gvpack -u $dots | sed 's/_gv[0-9]\+//g' | dot -Tjpg -o${buildHome}/target/dep-dot.jpg
gvpack -u $dots | sed 's/_gv[0-9]\+//g' | neato -Tjpg -o${buildHome}/target/dep-neato.jpg
gvpack -u $dots | sed 's/_gv[0-9]\+//g' | circo -Tjpg -o${buildHome}/target/dep-circo.jpg
gvpack -u $dots | sed 's/_gv[0-9]\+//g' | fdp -Tjpg -o${buildHome}/target/dep-fdp.jpg
gvpack -u $dots | sed 's/_gv[0-9]\+//g' | sfdp -Tjpg -o${buildHome}/target/dep-sfdp.jpg
