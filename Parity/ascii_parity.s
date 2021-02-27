	.text
//making the procedures global
	.global _add_parity_string
	.global _add_parity_byte
	.global _validate_parity_string
	.global _printS

//Xor 8 bits
_sum_of_bits:
	cmp r2, #0		//compare mask with 0
	beq _add_parity_bit	//if equal branch to apb
	and r3, r8, r2		//and of character with mask
	cmp r3, #0		//compare extracted bit with 0
	beq _zero		//if equal branch to zero
	bne _one		//if not equal bracn to one
_eor:
	eor r0, r0, r4		//Xor r0(bit before) with r4(current bit)
	lsr r2, r2, #1		//logical shift right of the mask
	bal _sum_of_bits	//branch always to sob

_zero:
	mov r4, #0		//r4 is current bit
	bal _eor		//branch always to Xor
_one:
	mov r4, #1		//r4 is current bit
	bal _eor		//branch always to Xor
//end of sum of bits

_return:			//return statement
	mov pc, lr

//add parity bit to HO bit
_add_parity_bit:
	cmp r0, #0		//check if result is 0
	beq _add_zero		//if equal branch to az
	bne _add_one		//if not equal branch to ao

_add_zero:
	add r8, r8, #0x0	//add parity bit in HO bit
	stmfd sp!, {r0}		//store parity bit into stack
//-----------------------
	mov r7, #4		//calls linux sys write command
	mov r0, #1		//writes to terminal
	mov r2, #7
	ldr r1, =_even_parity
	swi 0			//switches to supervisor mode
//-----------------------
	bal _storeC		//branch always to storeC

_add_one:
	add r8, r8, #0x80	//add parity bit in HO bit
	stmfd sp!, {r0}		//store parity bit into stack
//-----------------------
	mov r7, #4		//calls linux sys write command
	mov r0, #1		//writes to terminal
	mov r2, #7
	ldr r1, =_odd_parity
	swi 0			//switches to supervisor mode
//-----------------------
	bal _storeC		//branch always to storeC
//end of add parity bit

//go through every character in string
_add_parity_string:
	cmp r6, #6		//compare counter to 6
	beq _return		//if equal return

	ldrb r8, [r5, r6]	//load current char into r8
	b _sum_of_bits		//branch to sob

_storeC:
	strb r8, [r5, r6]	//store char with added parity to string
	mov r0, #0		//set r0 to 0
	mov r2, #64		//set mask
	add r6, r6, #1		//increment counter
	bal _add_parity_string	//branch always to aps(loop)

//Xor with every parity bit in the string
_add_parity_byte:
	cmp r6, #5		//compare counter to 5
	beq _print_parityS	//if equal print parity result

	ldmfd sp!,{r3}		//pop from stack to r3
	eor r0, r0, r3		//Xor element to current element
	add r6, r6, #1		//increment counter
	bal _add_parity_byte	//branch always to apb
_print_parityS:
	cmp r0, #0		//compare result to 0
	beq _evenS		//if equal print even
	bne _oddS		//if not equal print odd
_evenS:
//-----------------------
	mov r7, #4		//calls linux sys write command
	mov r0, #1		//writes to terminal
	mov r2, #14
	ldr r1, =_eS
	swi 0			//switches to supervisor mode
//-----------------------
	bal _return		//return
_oddS:
//-----------------------
	mov r7, #4		//calls linux sys write command
	mov r0, #1		//writes to terminal
	mov r2, #14
	ldr r1, =_oS
	swi 0			//switches to supervisor mode
//-----------------------
	bal _return		//return

//check HO bit of a character
_check_parity_bit:
	and r8, r8, #0x7F	//clear HO bit
	bal _storeC2		//branch always to storeC2

//go through string to check parity bits
_validate_parity_string:
	cmp r6, #6		//compare counter to 6
	beq _revertS		//if equal print reversed string

	ldrb r8, [r5, r6]	//load current char
	bal _check_parity_bit	//branch always to cpb

_storeC2:
	strb r8, [r5, r6]	//store changed char
	add r6, r6, #1		//increment counter
	bal _validate_parity_string	//branch always to vps

_printS:			//global write of string with parity bits
//-----------------------
	mov r7, #4		//calls linux sys write command
	mov r0, #1		//writes to terminal
	swi 0			//switches to supervisor mode
//-----------------------
	bal _return		//return

_revertS:			//message of revert string
//-----------------------
	mov r7, #4		//calls linux sys write command
	mov r0, #1		//writes to terminal
	mov r2, #39
	ldr r1, =_message1
	swi 0			//switches to supervisor mode
//-----------------------
	bal _printR		//print reverse string

_printR:
	mov r7, #4
	mov r0, #1
	mov r2, #6
	ldr r1, =_input
	swi 0
	mov pc, lr

.data
_even_parity:			//if parity of char is even
	.ascii " \nEven "
_odd_parity:			//if parity of char is odd
	.ascii " \nOdd  "
_eS:				//if parity of string is even
	.ascii " \nEven String\n"
_oS:				//if parity of string is odd
	.ascii " \nOdd String \n"
_message1:			//message of revert string
	.ascii " (w/ParityBits) == (ClearedParityBits) "
