#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#include <kernel/tty.h>

#include "vga.h"
 
static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;
static uint16_t* const VGA_MEMORY = (uint16_t*) 0xB8000;

size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;
uint16_t* terminal_buffer;

// r: these functions directly modify the VGA text mode buffer located at 0xB8000

void terminal_initialize(void)
{
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
	terminal_buffer = VGA_MEMORY; // r: VGA Text mode buffer is located at 0xB8000
    // r: fill the VGA text buffer, each entry is 16 bits.
    // first (highest) 4 bits for background color, following 4 bits for foreground color, and last (lowest) 8 bits for a character
	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
	}
}

void terminal_setcolor(uint8_t color)
{
	terminal_color = color;
}

void terminal_scroll(void) {
    // move all text back one line
    for (size_t y = 1; y < VGA_HEIGHT; y++) {
        for (size_t x = 0; x < VGA_WIDTH; x++) {
            const size_t previous_line_index = (y-1) * VGA_WIDTH + x;
            const size_t index = y * VGA_WIDTH + x;
            terminal_buffer[previous_line_index] = terminal_buffer[index];
        }
    }

    // clear last line
    for (size_t x = 0; x < VGA_WIDTH; x++)
        terminal_buffer[(VGA_HEIGHT - 1) * VGA_WIDTH + x] = vga_entry(' ', terminal_color);

    // Keep terminal_row as last row
    terminal_row = VGA_HEIGHT - 1;
}

// OSDev's implementation:
/* void terminal_scroll(int line) { */
/* 	int loop; */
/* 	char c; */
 
/* 	for(loop = line * (VGA_WIDTH * 2) + 0xB8000; loop < VGA_WIDTH * 2; loop++) { */
/* 		c = *loop; */
/* 		*(loop - (VGA_WIDTH * 2)) = c; */
/* 	} */
/* } */
 
/* void terminal_delete_last_line() { */
/* 	int x, *ptr; */
 
/* 	for(x = 0; x < VGA_WIDTH * 2; x++) { */
/* 		ptr = 0xB8000 + (VGA_WIDTH * 2) * (VGA_HEIGHT - 1) + x; */
/* 		*ptr = 0; */
/* 	} */
/* } */

void terminal_putentryat(char c, uint8_t color, size_t x, size_t y)
{
	const size_t index = y * VGA_WIDTH + x;
	terminal_buffer[index] = vga_entry(c, color);
}

void terminal_putchar(char c)
{
    if (c == '\n') {
        if (++terminal_row == VGA_HEIGHT)
            terminal_scroll();

        terminal_column=0;
        return;
    }

	terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
	if (++terminal_column == VGA_WIDTH) {
		terminal_column = 0;
        if (++terminal_row == VGA_HEIGHT) {
            terminal_scroll();
        }
	}
}

void terminal_write(const char* data, size_t size)
{
	for (size_t i = 0; i < size; i++)
		terminal_putchar(data[i]);
}

void terminal_writestring(const char* data)
{
	terminal_write(data, strlen(data));
}

