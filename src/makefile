all: boot.s kernel.c
	i686-elf-as boot.s -o boot.o
	i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	i686-elf-gcc -T linker.ld -o os.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

iso:
	mkdir -p isodir/boot/grub
	cp os.bin isodir/boot/os.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o os.iso isodir

sanity:
	@if grub-file --is-x86-multiboot os.bin; then echo multiboot confirmed; else echo the file is not multiboot; fi

run: iso
	qemu-system-i386 -cdrom os.iso

run2:
	qemu-system-i386 -kernel os.bin

