#!/usr/bin/env bash

source env.sh

# TODO: Add curl + tar of source

cd "$ROOT/other/objconv/source"
./build.sh
ln objconv "$ROOT/opt/other/bin/objconv"

cd "$ROOT/other/xorriso-1.5.4"
./configure --prefix="$ROOT/opt/other"
make
make install

cd "$ROOT/other/grub-2.06"
./autogen.sh
cd "$ROOT/other"
mkdir -p "build-grub"
cd build-grub
../grub-2.06/configure --prefix="$ROOT/opt/other" --disable-werror TARGET_CC=i686-elf-gcc TARGET_OBJCOPY=i686-elf-objcopy TARGET_STRIP=i686-elf-strip TARGET_NM=i686-elf-nm TARGET_RANLIB=i686-elf-ranlib --target=i686-elf
make
make install

cd "$ROOT"
