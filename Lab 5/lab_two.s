	.section .text
	.global _start
_start:
	mov r1, #50
 	mov r2, #60
  	add r0, r1, r2		@adding r1 and r2 into r0
   	sub r0, r1, r2		@subtracting r1 and r2 into r0

   	mov r2, #0xFFFFFFFF	@adding two 64-bit numbers
   	mov r3, #0x1
    	mov r4, #0xFFFFFFFF
    	mov r5, #0xFF
    	adds r0, r2, r4
     	adcs r1,r3, r5

	mov r0, #0x172		@attempting to load immediate value
					@it should give an error but it didn't

	ldr r0, HexValue		@Questions:
					@It changed from a mov to a ldr.

					@To load the value "HexValue" into 						@register 1 as a PC-relative 							@expression.

					@The PC-relative addressing mode can 						@be used to load a register with a 						@value stored in program memory a 						@short distance away from the current 						@instruction.

_exit:

	mov r7, #1
	swi 0

HexValue:
	.word 0x172
