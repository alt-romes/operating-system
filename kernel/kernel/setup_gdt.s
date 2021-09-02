.set GDT_SIZE, 5

.global gdt, setup_gdt

.section .bss
# Global Descriptor Table
gdt:
.skip 8*GDT_SIZE
    
.section .text

gdtr:
.skip 2+4 # 2 bytes for size, 4 bytes for address

.type setup_gdt,@function
setup_gdt:
    call create_gdt # this call will fill the global descriptor table with entries
    movw $GDT_SIZE, gdtr # fill GDT description structure with GDT size (number of entries)
    movl $gdt, gdtr+2 # fill GDT description structure with GDT address
    lgdt gdtr # "load gdt" must be called with a GDT description structure
    ret
