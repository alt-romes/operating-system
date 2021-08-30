#!/usr/bin/env bash

export ROOT="$(pwd)"

export PREFIX="$ROOT/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

# binutils
# cd "$ROOT/src"
# echo $(pwd)
# mkdir -p build-binutils
# cd build-binutils
# ../binutils-gdb/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
# make
# make install


# # gcc
cd "$ROOT/src"
which -- $TARGET-as || echo $TARGET-as is not in the PATH

mkdir -p build-gcc
cd build-gcc
../gcc/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
