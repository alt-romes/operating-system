#!/usr/bin/env bash

source env.sh

cd "$ROOT/other"

cd objconv/source
./build.sh
ln objconv "$ROOT/opt/bin"

cd "$ROOT/other/grub-2.06"
./configure --prefix="$PREFIX"
make install
