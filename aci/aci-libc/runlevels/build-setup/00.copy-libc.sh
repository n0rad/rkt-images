#!/bin/bash

cd ${ROOTFS}
mkdir -p usr/lib
ln -s usr/lib lib
ln -s usr/lib lib64

cp --preserve=links /usr/lib/libdl.so.* ${ROOTFS}/usr/lib  ||  cp --preserve=links /lib/x86_64-linux-gnu/libdl.so.* ${ROOTFS}/usr/lib
cp --preserve=links /usr/lib/libc.so.* ${ROOTFS}/usr/lib ||  cp --preserve=links /lib/x86_64-linux-gnu/libc.so.* ${ROOTFS}/usr/lib
cp --preserve=links /usr/lib/libpthread.so.* ${ROOTFS}/usr/lib ||  cp --preserve=links /lib/x86_64-linux-gnu/libpthread.so.* ${ROOTFS}/usr/lib
cp --preserve=links /lib64/ld-linux-x86-64.so.* ${ROOTFS}/lib64
