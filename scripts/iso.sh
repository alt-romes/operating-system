#!/bin/bash
set -e

source env.sh || (echo "Scripts must be run from the root project folder!" && exit 1)

. "$ROOT/scripts/build.sh"
 
mkdir -p $ROOT/isodir/boot/grub
 
cp "$ROOT/sysroot/boot/osrm.kernel" "$ROOT/isodir/boot/osrm.kernel"
cp -f "$ROOT/config/grub.cfg" "$ROOT/isodir/boot/grub/grub.cfg"
grub-mkrescue -o "$ROOT/osrm.iso" "$ROOT/isodir"
