#ifndef _KERNEL_GDT_H
#define _KERNEL_GDT_H

#include <stdint.h>

void setup_gdt(void);
void create_gdt(uint64_t* gdt_addr);

#endif
