#!/bin/bash
set -e

source env.sh || (echo "Scripts must be run from the root project folder!" && exit 1)

. "$ROOT/scripts/headers.sh"
 
for PROJECT in $PROJECTS; do
  (cd $PROJECT && DESTDIR="$SYSROOT" $MAKE install)
done
