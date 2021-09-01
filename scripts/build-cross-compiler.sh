#!/usr/bin/env bash

set -e

source env.sh || (echo "Scripts must be run from the root project folder!" && exit 1)

TARGET=i686-elf
PREFIX="$ROOT/opt/cross"

# binutils
cd "$ROOT/cross"

git clone git://sourceware.org/git/binutils-gdb.git

# curl -LO https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.gz
# tar zxf binutils-2.37.tar.gz

mkdir -p build-binutils
cd build-binutils
../binutils-gdb/configure --target="$TARGET" --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install


# gcc
cd "$ROOT/cross"

git clone git://gcc.gnu.org/git/gcc.git

which -- "$TARGET-as" || echo "$TARGET-as" is not in the PATH

mkdir -p build-gcc
cd build-gcc
../gcc/configure --target="$TARGET" --prefix="$PREFIX" --disable-nls --enable-languages=c --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc

cd "$ROOT"
