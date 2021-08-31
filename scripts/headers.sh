#!/bin/bash
set -e

source env.sh || (echo "Scripts must be run from the root project folder!" && exit 1)

. "$ROOT/scripts/config.sh"
 
mkdir -p "$SYSROOT"
 
for PROJECT in $SYSTEM_HEADER_PROJECTS; do
  (cd $PROJECT && DESTDIR="$SYSROOT" $MAKE install-headers)
done
