	.text
	.global _start
	.global _input
//main
_start:
//print string
//-----------------------
	mov r7, #4		//calls linux sys write command
	mov r0, #1		//writes to terminal
	mov r2, #6
	ldr r1, =_input
	swi 0			//switches to supervisor mode
//-----------------------
//_write procedure arguments
//	mov r2, #19
//	ldr r1, =_prompt
//	bl _write
//_read procedure arguments
//	mov r2, #7
//	ldr r5, =_input
//	bl _read

//_add_parity_string arguments
	mov r0, #0
	mov r8, #0
	mov r2, #64
	ldr r5, =_input
	mov r6, #0
	bl _add_parity_string

//_add_parity_byte arguments
	mov r6, #0
	ldmfd sp!, {r0}
	bl _add_parity_byte

	mov r2, #6
	ldr r1, =_input
	bl _printS

//_validate_parity_string arguments
	mov r6, #0
	bl _validate_parity_string

	mov r0, #0
	mov r8, #0
	mov r2, #64
	ldr r5, =_input
	mov r6, #0
	bl _add_parity_string

	mov r6, #0
	ldmfd sp!, {r0}
	bl _add_parity_byte

//exit procedure
_exit:
	mov r7, #1
	swi 0
.data
//_prompt:
//	.ascii "Enter 6 characters\n"
_input:
	.ascii "zigzag"
