#!/bin/bash
set -e # fail if any command fails

source env.sh || (echo "Scripts must be run from the root project folder!" && exit 1)

. "$ROOT/scripts/iso.sh"
 
"qemu-system-$("$ROOT/scripts/target-triplet-to-arch.sh" "$HOST")" -cdrom "$ROOT/osrm.iso"
