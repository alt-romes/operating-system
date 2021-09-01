ROOT=$(shell cd .. && pwd)
OS_NAME=$(shell $(ROOT)/scripts/os-name.sh)

HOST=$(shell $(ROOT)/scripts/default-host.sh)
HOSTARCH= i386

ARCHDIR=arch/$(HOSTARCH)
 
include $(ARCHDIR)/make.config
 
# Compilation flags
CFLAGS?=-O2 -g # C flags
CPPFLAGS?= 	   # C preprocessor flags

CFLAGS:=$(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS:=$(CPPFLAGS) -D__is_kernel -Iinclude

CFLAGS:=$(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)

LDFLAGS=
LIBS=-nostdlib -lk -lgcc
 
LDFLAGS:=$(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS:=$(LIBS) $(KERNEL_ARCH_LIBS)
 
# Kernel dependencies (architecture dependencies + kernel)
KERNEL_SRCS=$(KERNEL_ARCH_SRCS) kernel/kernel.c

# Objects to make the kernel are the kernel objects :)
KERNEL_OBJS=$(KERNEL_SRCS:%=%.o)
 
.PHONY: all clean install install-headers install-kernel

all: $(OS_NAME).kernel
 
$(OS_NAME).kernel: $(KERNEL_OBJS) $(ARCHDIR)/linker.ld
	@$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(KERNEL_OBJS) $(LIBS)
	@if grub-file --is-x86-multiboot $(OS_NAME).kernel; then echo "success, kernel is multiboot"; fi
 
%.c.o: %.c
	@$(CC) -MD -c $< -o $@ -std=gnu11 $(CFLAGS) $(CPPFLAGS)
 
%.s.o: %.s
	@$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)

# include rules from auto dependencies generated with -MD
-include $(KERNEL_OBJS:.o=.d)
 
# Other commands
clean:
	@rm -f $(OS_NAME).kernel
	@rm -f $(KERNEL_OBJS)
	@rm -f $(KERNEL_OBJS:.o=.d)
 
install: install-headers install-kernel

# Sysroot destination, boot dir, include dir
DESTDIR?=../sysroot
BOOTDIR?=/boot
INCLUDEDIR?=/usr/include
 
install-headers:
	@mkdir -p $(DESTDIR)$(INCLUDEDIR)
	@cp -R include/. $(DESTDIR)$(INCLUDEDIR)/.
 
install-kernel: $(OS_NAME).kernel
	@mkdir -p $(DESTDIR)$(BOOTDIR)
	@cp $(OS_NAME).kernel $(DESTDIR)$(BOOTDIR)

help:
	@echo "Don't forget to source ../scripts/config.sh to set CC and other environment variables"

