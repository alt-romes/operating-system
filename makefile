ROOT=$(shell pwd)
include config/environment.make.config

.PHONY: headers clean

build: headers
	$(MAKE) -C libc install
	$(MAKE) -C kernel install

headers:
	mkdir -p $(SYSROOT)
	$(MAKE) -C kernel install-headers
	$(MAKE) -C libc install-headers

$(OS_NAME).iso: build
	mkdir -p isodir/boot/grub
	cp -f $(SYSROOT)/boot/$(OS_NAME).kernel isodir/boot/$(OS_NAME).kernel
	cp -f config/grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o $@ isodir

run: $(OS_NAME).iso
	qemu-system-$(HOSTARCH) --cdrom $<

clean:
	$(MAKE) -C kernel clean
	$(MAKE) -C libc clean
	rm -rf sysroot
	rm -rf isodir
	rm -rf osrm.iso

