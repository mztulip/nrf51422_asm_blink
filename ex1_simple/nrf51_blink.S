//https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html
//https://sourceware.org/binutils/docs/as/ARM-Directives.html
.thumb
.syntax unified

.global vector_table
vector_table:
	.long  0x20001000 //Set stack pointer
	.long   __start //Reset_Handler
	.long   fault //NMI_Handler
	.long   fault //HardFault_Handler

//https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_7.html
//

//    LED1 (green) = P0.21
//    LED2 (green) = P0.22
//    LED3 (green) = P0.23
//    LED4 (green) = P0.24
.thumb_func
__start:
.equ	gpio_dir, 0x50000514
.equ	gpio_out, 0x50000504
	ldr r1,=(1<<21)
	ldr r0,=gpio_dir
	str r1,[r0]
loop:
	nop
	bl delay
	bl led_toogle
	b loop

fault:
	b fault

delay:	
	ldr	r0, =200000
loop2:
	nop
	subs	r0, #1
	cmp	r0, #0
	bge	loop2
	bx	lr

led_toogle:
	ldr r0,=gpio_out
	ldr r1,[r0]
	ldr r2,=(1<<21)
	eors r1,r2
	str r1,[r0]
	bx lr
