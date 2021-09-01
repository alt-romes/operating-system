#!/bin/bash
set -e # fail if any command fails

source env.sh || (echo "Scripts must be run from the root project folder!" && exit 1)

. "$ROOT/scripts/iso.sh"
 
"qemu-system-i386" -cdrom "$ROOT/osrm.iso"
