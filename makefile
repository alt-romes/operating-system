ROOT=$(shell pwd)
include config/environment.make.config

.PHONY: clean

# This would be nice to fix, but it's not important at the moment -- even though `make -c libc install` doesn't build again, libk.a probably changes, so when `make -c kernel install` is run, it is rebuilt...., and libc will be rebuilt if `headers` is run previously

build: headers
	$(MAKE) -C libc install
	$(MAKE) -C kernel install

headers:
	@mkdir -p $(SYSROOT)
	$(MAKE) -C kernel install-headers
	$(MAKE) -C libc install-headers

$(OS_NAME).iso: $(SYSROOT)/boot/$(OS_NAME).kernel
	@mkdir -p isodir/boot/grub
	@cp -f $(SYSROOT)/boot/$(OS_NAME).kernel isodir/boot/$(OS_NAME).kernel
	@cp -f config/grub.cfg isodir/boot/grub/grub.cfg
	@grub-mkrescue -o $@ isodir

run: $(OS_NAME).iso
	qemu-system-$(HOSTARCH) --cdrom $<

clean:
	@$(MAKE) -C kernel clean
	@$(MAKE) -C libc clean
	@rm -rf sysroot
	@rm -rf isodir
	@rm -rf osrm.iso

