**Features**
- kernel printf through the VGA text mode
- flat memory model (Global Descriptor Table entries are all full-width and overlapping (base is 0B and limit is 4GB), i.e. memory segmentation is unused / invisible)

cross-compilation and cross(?) grub:
```
# ./scripts/build-cross-compiler.sh # builds gcc targeting elf-i686 and binutils targeting elf-i686
# Or, the better alternative:
brew install i686-elf-gcc
brew install i686-elf-binutils

PYTHON=python3 ./scripts/build-grub.sh # builds grub and its dependencies, and uses the elf-i686 binutils and gcc above to compile grub
```

load environment to work on the OS (e.g. add (cross) elf-i686-gcc to $PATH) (should be done on the directory containing `env.sh` to correctly set `$ROOT`)
```
source env.sh
```

building kernel:
```
make
```

building iso file with grub and running:
```
make run
```

editing the make configuration
```
vim config/environment.make.config
```

the process is currently described as follows:
- `make` variables are defined in `config/environment.make.config`
- `kernel/` contains the kernel code, `kernel/makefile` can build the kernel image `$(OS_NAME).kernel` (but requires libc/libk to be in `sysroot`), and can install the kernel and include header files to `sysroot` with `make install` (run in `kernel/`)
- `libc/` contains the freestanding `libk` and the hosted `libc` (to be developed) code, it compiles the libraries and saves them to `sysroot` with `make install` (in `libc`, or `make -C libc install` from `$ROOT`)
- `sysroot/` is a directory built when compiling the OS. It resembles the `/` file hierarchy in UNIX, storing the kernel in `/boot` and library headers in `/usr/include` and libraries in `/usr/lib`. It's used in compilation to store (first) all header files (so that the compilation succeedes), and then, for now, `/usr/lib/libk.a` (already required to be present here when building the kernel (-- that's why libc is built first)) and `/boot/os_name.kernel`
- `isodir/` is a directory built when creating the `.iso` bootable cdrom, and holds the kernel (copied from `sysroot/boot/os_name.kernel`) and GRUB config (copied from `config/grub.cfg`)
- `scripts/` contains useful scripts (for now scripts to build the cross compiler)
- `cross/` is generated when building the cross compiler, `opt/` has the built cross compilation and grub binaries
- `env.sh` is a script that sets the `$ROOT` environment variable to the project's root, and adds the cross compilation tools from `opt/` to the `$PATH` environment variable
