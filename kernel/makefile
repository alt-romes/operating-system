ROOT=$(shell cd .. && pwd)
include $(ROOT)/config/environment.make.config

ARCHDIR=arch/$(HOSTARCH)
 
include $(ARCHDIR)/make.config
 
# Compilation flags
# Default CFLAGS && CPPFLAGS defined in $ROOT/config/environment.make.config

CFLAGS:=$(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS:=$(CPPFLAGS) -D__is_kernel -Iinclude

CFLAGS:=$(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)

LDFLAGS=
LIBS=-nostdlib -lk -lgcc
 
LDFLAGS:=$(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS:=$(LIBS) $(KERNEL_ARCH_LIBS)
 
# Kernel dependencies (architecture dependencies + kernel)
SRC_DIRS=kernel
KERNEL_SRCS=$(KERNEL_ARCH_SRCS) $(shell find $(SRC_DIRS) -name *.s -or -name *.c)

# Objects to make the kernel are the kernel objects :)
KERNEL_OBJS=$(KERNEL_SRCS:%=%.o)
 
.PHONY: all clean install install-headers install-kernel

all: $(OS_NAME).kernel
 
$(OS_NAME).kernel: $(KERNEL_OBJS) $(ARCHDIR)/linker.ld
	$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(KERNEL_OBJS) $(LIBS)
	@if grub-file --is-x86-multiboot $(OS_NAME).kernel; then echo "success, kernel is multiboot"; fi
 
%.c.o: %.c
	$(CC) -MD -c $< -o $@ -std=gnu11 $(CFLAGS) $(CPPFLAGS)
 
%.s.o: %.s
	$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)

# include rules from auto dependencies generated with -MD
-include $(KERNEL_OBJS:.o=.d)
 
# Other commands
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

