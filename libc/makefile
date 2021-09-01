ROOT=$(shell cd .. && pwd)
OS_NAME=$(shell $(ROOT)/scripts/os-name.sh)

HOST=$(shell $(ROOT)/scripts/default-host.sh)
HOSTARCH=i386

ARCHDIR=arch/$(HOSTARCH)
 
include $(ARCHDIR)/make.config
 
# Compilation flags 
CFLAGS?=-O2 -g # C flags
CPPFLAGS?=     # C preprocessor flags
 
CFLAGS:=$(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS:=$(CPPFLAGS) -D__is_libc -Iinclude
LIBK_CFLAGS:=$(CFLAGS)
LIBK_CPPFLAGS:=$(CPPFLAGS) -D__is_libk
 
CFLAGS:=$(CFLAGS) $(ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(ARCH_CPPFLAGS)
LIBK_CFLAGS:=$(LIBK_CFLAGS) $(KERNEL_ARCH_CFLAGS)
LIBK_CPPFLAGS:=$(LIBK_CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)
 
FREESRCS=\
$(ARCH_FREESRCS) \
stdio/printf.c \
stdio/putchar.c \
stdio/puts.c \
string/strlen.c \
 
HOSTEDOBJS=\
$(ARCH_HOSTEDSRCS) \
 
SRCS=\
$(FREESRCS) \
$(HOSTEDSRCS) \

FREEOBJS=$(FREESRCS:%=%.o)
HOSTEDOBJS=$(HOSTEDSRCS:%=%.o)

OBJS=$(FREEOBJS) $(HOSTEDOBJS)
 
LIBK_OBJS=$(FREEOBJS:.o=.libk.o)
 
 
#BINARIES=libc.a libk.a # Not ready for libc yet.
BINARIES=libk.a
 
.PHONY: all clean install install-headers install-libs
 
all: $(BINARIES)
 
libc.a: $(OBJS)
	$(AR) rcs $@ $(OBJS)
 
libk.a: $(LIBK_OBJS)
	$(AR) rcs $@ $(LIBK_OBJS)
 
%.c.o: %.c
	$(CC) -MD -c $< -o $@ -std=gnu11 $(CFLAGS) $(CPPFLAGS)
 
%.s.o: %.s
	$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)
 
%.c.libk.o: %.c
	$(CC) -MD -c $< -o $@ -std=gnu11 $(LIBK_CFLAGS) $(LIBK_CPPFLAGS)
 
%.s.libk.o: %.s
	$(CC) -MD -c $< -o $@ $(LIBK_CFLAGS) $(LIBK_CPPFLAGS)

-include $(OBJS:.o=.d)
-include $(LIBK_OBJS:.o=.d)
 
# Other commands
clean:
	rm -f $(BINARIES) *.a
	rm -f $(OBJS) $(LIBK_OBJS) *.o */*.o */*/*.o
	rm -f $(OBJS:.o=.d) $(LIBK_OBJS:.o=.d) *.d */*.d */*/*.d
 
install: install-headers install-libs
 
# Sysroot destination, include dir, lib dir
DESTDIR?=../sysroot
INCLUDEDIR?=/usr/include
LIBDIR?=/usr/lib

install-headers:
	mkdir -p $(DESTDIR)$(INCLUDEDIR)
	cp -R include/. $(DESTDIR)$(INCLUDEDIR)/.
 
install-libs: $(BINARIES)
	mkdir -p $(DESTDIR)$(LIBDIR)
	cp $(BINARIES) $(DESTDIR)$(LIBDIR)

