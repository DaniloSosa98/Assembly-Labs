	.section .init
	.global _start

	//values
	.equ Base,		0x3f200000 		//Base address
	.equ GPFSEL2,	0x08			//Function Select register 2 offset 
	.equ GPSET0,	0x1c			//GPIO Set register 0 offset
	.equ GPCLR0,	0x28			//GPIO Clear register 0 offset

	//Prepares bits in function select
	.equ Set_Bits, 	0x1209			//sets all the bits

	//sets bits we are using
	.equ Set_Bit20,	0x100000		//sets bit 20
	.equ Set_Bit21,	0x200000		//sets bit 21
	.equ Set_Bit23,	0x800000		//sets bit 23
	.equ Set_Bit24,	0x1000000		//sets bit 24

	.equ Counter,	0xf000

	_start:							//Start label

	ldr r0, =Base					//load register with Base
	ldr r2, =Counter				//Load register with Counter
	ldr r1, =Set_Bits				//Set bits in GPFSEL2
	str r1, [r0,#GPFSEL2]

	//Calls
	_calls:
	ldr r1, =Set_Bit20				//Set bit 20 in GPSET0
	bl loop
	ldr r1, =Set_Bit21				//Set bit 21 in GPSET0
	bl loop
	ldr r1, =Set_Bit23				//Set bit 23 in GPSET0
	bl loop
	ldr r1, =Set_Bit24				//Set bit 24 in GPSET0
	bl loop
	ldr r1, =Set_Bit24				//Set bit 24 in GPSET0
	bl loop
	ldr r1, =Set_Bit23				//Set bit 23 in GPSET0
	bl loop
	ldr r1, =Set_Bit21				//Set bit 21 in GPSET0
	bl loop
	ldr r1, =Set_Bit20				//Set bit 20 in GPSET0
	bl loop
	bal _calls

	//Make LEDs Blink
	loop:
		//Turn LED on 
		str r1, [r0,#GPSET0]
		
		//Delay On
		mov r10, #0
		delayON://loop to large number
			add r10, r10, #1
			cmp r10, r2	
			bne delayON

		//Turn LED off	
		str r1, [r0,#GPCLR0]
		
		//Delay Off
		mov r10, #0
		delayOFF:
			add r10, r10, #1
			cmp r10, r2	
			bne delayOFF
	mov pc, lr
