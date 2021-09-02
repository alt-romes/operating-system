#include <stdio.h>

#include <kernel/tty.h>
/* #include <kernel/gdt.h> */

extern void setup_gdt(void);

void kernel_main(void* multiboot_structure) {

    setup_gdt();

	terminal_initialize();
	printf("Hello, kernel World!\nNew line!\n A ");
}
