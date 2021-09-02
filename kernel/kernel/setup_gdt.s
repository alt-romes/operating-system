.section .bss
gdt:
.skip 8*5 # 5 entries of 8 bytes

.section .text
.global setup_gdt
.type setup_gdt,%function
setup_gdt:
    ret
