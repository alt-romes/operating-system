ROOT=$(shell cd .. && pwd)
OS_NAME=$(shell $(ROOT)/scripts/os-name.sh)

DEFAULT_HOST=$(shell $(ROOT)/scripts/default-host.sh)
HOST?=DEFAULT_HOST
HOSTARCH=$(shell $(ROOT)/scripts/target-triplet-to-arch.sh $(HOST))
 
ARCHDIR=arch/$(HOSTARCH)
 
include $(ARCHDIR)/make.config
 
# Compilation flags
CFLAGS?=-O2 -g
CPPFLAGS?=
LDFLAGS?=
LIBS?=
 
CFLAGS:=$(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS:=$(CPPFLAGS) -D__is_kernel -Iinclude
LDFLAGS:=$(LDFLAGS)
LIBS:=$(LIBS) -nostdlib -lk -lgcc
 
CFLAGS:=$(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)
LDFLAGS:=$(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS:=$(LIBS) $(KERNEL_ARCH_LIBS)

 
# Sysroot destination, boot dir, include dir
DESTDIR?=
PREFIX?=/usr/local
EXEC_PREFIX?=$(PREFIX)
BOOTDIR?=$(EXEC_PREFIX)/boot
INCLUDEDIR?=$(PREFIX)/include
 
# Kernel dependencies (architecture dependencies + kernel)
KERNEL_SRCS=$(KERNEL_ARCH_SRCS) kernel/kernel.c

# Objects to make the kernel are the kernel objects :)
KERNEL_OBJS=$(KERNEL_SRCS:%=%.o)
 
# OBJS=\
# $(ARCHDIR)/crti.o \
# $(ARCHDIR)/crtbegin.o \
# $(KERNEL_OBJS) \
# $(ARCHDIR)/crtend.o \
# $(ARCHDIR)/crtn.o \
 
# LINK_LIST=\
# $(LDFLAGS) \
# $(ARCHDIR)/crti.o \
# $(ARCHDIR)/crtbegin.o \
# $(KERNEL_OBJS) \
# $(LIBS) \
# $(ARCHDIR)/crtend.o \
# $(ARCHDIR)/crtn.o \
 
.PHONY: all clean install install-headers install-kernel

all: $(OS_NAME).kernel
 
$(OS_NAME).kernel: $(KERNEL_OBJS) $(ARCHDIR)/linker.ld
	@$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(KERNEL_OBJS) $(LIBS)
	@if grub-file --is-x86-multiboot $(OS_NAME).kernel; then echo "success, kernel is multiboot"; fi
 
%.c.o: %.c
	@$(CC) -MD -c $< -o $@ -std=gnu11 $(CFLAGS) $(CPPFLAGS)
 
%.s.o: %.s
	@$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)
 
clean:
	@rm -f $(OS_NAME).kernel
	@rm -f $(KERNEL_OBJS)
	@rm -f $(KERNEL_OBJS:.o=.d)
 
install: install-headers install-kernel
 
install-headers:
	@mkdir -p $(DESTDIR)$(INCLUDEDIR)
	@cp -R include/. $(DESTDIR)$(INCLUDEDIR)/.
 
install-kernel: $(OS_NAME).kernel
	@mkdir -p $(DESTDIR)$(BOOTDIR)
	@cp $(OS_NAME).kernel $(DESTDIR)$(BOOTDIR)
 
# include auto dependencies generated with -MD (todo: read more on it)
-include $(KERNEL_OBJS:.o=.d)

help:
	@echo "Don't forget to source ../scripts/config.sh to set CC and other environment variables"
