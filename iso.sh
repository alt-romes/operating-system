#!/bin/sh
set -e
. ./build.sh
 
mkdir -p isodir/boot/grub
 
cp sysroot/boot/osrm.kernel isodir/boot/osrm.kernel
cp -f grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o osrm.iso isodir
