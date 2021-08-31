OS_NAME=$(shell ../os-name.sh)

DEFAULT_HOST=$(shell ../default-host.sh)
HOST?=DEFAULT_HOST
HOSTARCH=$(shell ../target-triplet-to-arch.sh $(HOST))
 
CFLAGS?=-O2 -g -std=gnu99
CPPFLAGS?=
LDFLAGS?=
LIBS?=
 
DESTDIR?=
PREFIX?=/usr/local
EXEC_PREFIX?=$(PREFIX)
BOOTDIR?=$(EXEC_PREFIX)/boot
INCLUDEDIR?=$(PREFIX)/include
 
CFLAGS:=$(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS:=$(CPPFLAGS) -D__is_kernel -Iinclude
LDFLAGS:=$(LDFLAGS)
LIBS:=$(LIBS) -nostdlib -lk -lgcc
 
ARCHDIR=arch/$(HOSTARCH)
 
include $(ARCHDIR)/make.config
 
CFLAGS:=$(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)
LDFLAGS:=$(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS:=$(LIBS) $(KERNEL_ARCH_LIBS)
 
KERNEL_OBJS=\
$(KERNEL_ARCH_OBJS) \
kernel/kernel.o \

OBJS = $(KERNEL_OBJS)
 
# OBJS=\
# $(ARCHDIR)/crti.o \
# $(ARCHDIR)/crtbegin.o \
# $(KERNEL_OBJS) \
# $(ARCHDIR)/crtend.o \
# $(ARCHDIR)/crtn.o \

LINK_LIST =\
$(KERNEL_OBJS) \
$(LIBS) \
 
# LINK_LIST=\
# $(LDFLAGS) \
# $(ARCHDIR)/crti.o \
# $(ARCHDIR)/crtbegin.o \
# $(KERNEL_OBJS) \
# $(LIBS) \
# $(ARCHDIR)/crtend.o \
# $(ARCHDIR)/crtn.o \
 
.PHONY: all clean install install-headers install-kernel
.SUFFIXES: .o .c .S
 
all: $(OS_NAME).kernel
 
$(OS_NAME).kernel: $(OBJS) $(ARCHDIR)/linker.ld
	$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(LINK_LIST)
	if grub-file --is-x86-multiboot $(OS_NAME).kernel; then echo "success, kernel is multiboot"; fi
 
.c.o:
	$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)
 
.S.o:
	$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)
 
clean:
	rm -f $(OS_NAME).kernel
	rm -f $(OBJS) *.o */*.o */*/*.o
	rm -f $(OBJS:.o=.d) *.d */*.d */*/*.d
 
install: install-headers install-kernel
 
install-headers:
	mkdir -p $(DESTDIR)$(INCLUDEDIR)
	cp -R include/. $(DESTDIR)$(INCLUDEDIR)/.
 
install-kernel: $(OS_NAME).kernel
	mkdir -p $(DESTDIR)$(BOOTDIR)
	cp $(OS_NAME).kernel $(DESTDIR)$(BOOTDIR)
 
-include $(OBJS:.o=.d)
