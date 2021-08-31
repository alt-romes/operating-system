#!/bin/bash
set -e

. env.sh || (echo "Scripts must be run from the root project folder!" && exit 1)

echo $ROOT
cd "$ROOT"

. "$ROOT/scripts/config.sh"
 
for PROJECT in $PROJECTS; do
  (cd $PROJECT && $MAKE clean)
done
 
rm -rf "$ROOT sysroot"
rm -rf isodir
rm -rf osrm.iso
