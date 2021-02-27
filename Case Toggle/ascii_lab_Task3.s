	.text
	.global _start		@Tells the kernel where execution begins
_start:				@Marks position of entry point

_display:			@Label of the code written to display in terminal
	mov r7, #4		@Linux Sys call number for 'write'
	mov r0, #1		@Writes to terminal
	mov r2, #28		@Character size in bytes
	ldr r1, =_message	@Source of write
	swi 0			@Switches to Supervisor mode

_read:
	mov r7, #3		@Linux Sys call number for 'read'
	mov r0, #0		@Reading from keyboard
	mov r2, #10		@Character size in bytes
	ldr r1, =_buffer	@Destination of the read
	swi 0			@Switches to Supervisor mode

	mov r2, #0		@Initiates counter at 0 for encrypt:

_encrypt:
	ldrb r0, [r1, r2]	@Implicit addition of r1 + r2 to get an effective address
	eor r0, r0, #15		@'xor's' the character with the key for encryption
	strb r0,[r1, r2]	@Writes the byte back to buffer
	add r2, r2, #1		@Increments r2 (counter) + 1
	cmp r2, #10		@Compare counter to 10 to know if string limit is met
	blt _encrypt		@if less than 10 (string length limit) branch to encrypt:

	mov r7, #4		@Linux Sys call number for 'write'
	mov r0, #1		@Writing to terminal
	mov r2, #10		@Character size in bytes
	ldr r1, =_buffer	@Source of the write
	swi 0			@Switches to Supervisor mode

	mov r2, #0		@Initiates counter at 0 for decrypt:

_decrypt:
	ldrb r0, [r1, r2]       @Implicit addition of r1 + r2 to get an effective address

	eor r0, r0, #15		@'Xor' the characters with the key for decryption
	strb r0,[r1, r2]	@Writes the byte back to buffer
	add r2, r2, #1		@Increments r2 (counter) + 1
	cmp r2, #10		@Compare counter to 10 to know if string limit is met
	blt _decrypt		@if less than 10 (string length limit) branch to decrypt:

	mov r7, #4		@Linux Sys call number for 'write'
	mov r0, #1		@writes to terminal
	mov r2, #10		@character size in bytes
	ldr r1, =_buffer	@Source of the write
	swi 0                   @Switches to Supervisor mode

_exit:				@Label of exit routine
	mov r7, #1		@Calls exit routine
	swi 0			@Switches to Supervisor mode

.data				@Declare data after code
_message:			@Label for instruction to user
	.ascii "Enter a 10 character string\n"

_buffer:
	.ascii ""		@Label for user´s input string
