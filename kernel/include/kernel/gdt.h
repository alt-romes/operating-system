#ifndef _KERNEL_GDT_H
#define _KERNEL_GDT_H

#include <stdint.h>

extern uint64_t* gdt;
void setup_gdt(void);

void create_gdt(void);

#endif
