6	.text
	.global _start		@Tells the kernel where execution begins
_start:				@Marks position of entry point

_display:			@Label of the code written to display in terminal
	mov r7, #4		@Linux Sys call number for 'write'
	mov r0, #1		@Writing to terminal
	mov r2, #28		@Character size in bytes
	ldr r1, =_message	@Source of the write
	swi 0			@Switches to Supervisor mode

_read:				@Label of the code written to read the string
	mov r7, #3		@Linux Sys call number for 'read'
	mov r0, #0		@Reading from keyboard
	mov r2, #10		@Character size in bytes
	ldr r1, =_buffer	@Destination of the read
	swi 0			@Switches to Supervisor mode

	mov r2, #0		@Initiates counter at 0 for toggle:

_toggle:
	ldrb r0, [r1, r2]	@Implicit addition of r1 + r2 to get an effective address

	cmp r0, #65		@Compares character in r0 to 65 which is ´A´ in ascii 
	blt _counterI		@if its less (non-alphabetical) branch to counterI:
				@if its greater it continues to upper case the character

	@and r0, r0, #0xDF	@'and' r0 with the mask (1101_1111) to clear bit 5
	bic r0, r0, #0x20	@'bic' r0 with the mask (0010_0000) to clear bit 5
	strb r0,[r1, r2]	@Writes the byte back to buffer
	add r2, r2, #1		@Increments r2 (counter) + 1
	cmp r2, #10		@Compare counter to 10 to know if string limit is met
	blt _toggle		@if less than 10 (string length limit) branch to toggle:

	mov r7, #4		@Linux Sys call number for 'write'
	mov r0, #1		@Writing to terminal
	mov r2, #10		@Character size in bytes
	ldr r1, =_buffer	@Source of the write
	swi 0			@Switches to Supervisor mode

_counterI:			@Label to increment counter if the character is non-alphabetical
	add r2, r2, #1		@Increments r2 (counter) + 1
	blt _toggle		@Branches back to toggle:

_exit:				@Label of exit routine
	mov r7, #1		@Calls exit routine
	swi 0			@Switches to Supervisor mode

.data				@Declare data after code
_message:			@Label for instruction tu user
	.ascii "Enter a 10 character string\n"

_buffer: 			@Label for user´s input string
	.ascii ""
