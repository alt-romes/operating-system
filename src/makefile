CC = /Users/romes/projects/osrm/opt/cross/bin/i686-elf-gcc
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra -Wno-array-bounds

os.bin: kernel.o boot.o
	${CC} -T linker.ld -o os.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

kernel.o: kernel.c boot.o
	${CC} ${CFLAGS} -c kernel.c -o kernel.o

boot.o: boot.s
	i686-elf-as boot.s -o boot.o

os.iso: os.bin
	mkdir -p isodir/boot/grub
	cp os.bin isodir/boot/os.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o os.iso isodir

sanity:
	@if grub-file --is-x86-multiboot os.bin; then echo multiboot confirmed; else echo the file is not multiboot; fi

run: os.iso
	qemu-system-i386 -cdrom os.iso

run2: os.bin
	qemu-system-i386 -kernel os.bin

