cross-compilation and cross? grub:
```
./build-cross-compiler.sh # builds gcc targeting elf-i686 and binutils targeting elf-i686
./build-grub.sh # builds grub and its dependencies, and uses the elf-i686 binutils and gcc above to compile grub
```

load environment to work on the OS (e.g. elf-i686-gcc to $PATH). should be done on the directory containing `env.sh` to correctly set `$ROOT`, et etc...
```
source env.sh
```

building kernel:
```
cd src
make
```

building iso file with grub and running:
```
make run # boot from iso file
```

alternatively run the kernel directly using qemu (which can boot kernels "adhering to" multiboot):
```
make run2 # boot using qemu support for multiboot
```
