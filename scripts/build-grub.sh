#!/usr/bin/env bash

set -e

source env.sh || (echo "Scripts must be run from the root project folder!" && exit 1)

# objconv
cd "$ROOT/other"

curl -LO http://www.agner.org/optimize/objconv.zip
unzip objconv.zip -d objconv
rm objconv.zip
cd objconv
unzip source.zip -d source
rm source.zip

cd "$ROOT/other/objconv/source"
./build.sh
ln -f objconv "$ROOT/opt/other/bin/objconv"

# xorriso
cd "$ROOT/other"

curl -LO https://www.gnu.org/software/xorriso/xorriso-1.5.4.pl02.tar.gz
tar zxf xorriso-1.5.4.pl02.tar.gz
rm xorriso-1.5.4.pl02.tar.gz

cd "$ROOT/other/xorriso-1.5.4"
./configure --prefix="$ROOT/opt/other"
make
make install


# grub
cd "$ROOT/other"

curl -LO https://ftp.gnu.org/gnu/grub/grub-2.06.tar.gz
tar zxf grub-2.06.tar.gz
rm grub-2.06.tar.gz

cd "$ROOT/other/grub-2.06"
./autogen.sh
cd "$ROOT/other"
mkdir -p "build-grub"
cd build-grub
../grub-2.06/configure --prefix="$ROOT/opt/other" --disable-werror TARGET_CC=i686-elf-gcc TARGET_OBJCOPY=i686-elf-objcopy TARGET_STRIP=i686-elf-strip TARGET_NM=i686-elf-nm TARGET_RANLIB=i686-elf-ranlib --target=i686-elf
make
make install

cd "$ROOT"
