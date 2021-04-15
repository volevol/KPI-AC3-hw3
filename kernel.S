.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

#define A #8
#define B #4
#define C #2

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector

vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata

	data: .asciz "kernel started!\n"
	final: .asciz "Result value in register #3: "
    
.section .text

__kernel_reset__:
	ldr r0, =data
	bl dbgput_line

// calculate
	mov r2, A
	sub r3, r2, B
	mov r4, 0
	cmp r3, r4
	
ITE GE
	addGE r3, r2, B
	subLT r3, r2, B
	
	mov r4, C
	sdiv r3, r4

	ldr r0, =final
	bl dbgput
	mov r0, r3
	bl dbgput_num
    
end:
	b end
