	.text
	.global _minMax
	.global _search
	.global _bubble
	.global to_lower
	.global CheckDoub
//PROCEDURES
//minMax
_minMax:
	cmp r6, #20		//compare counter to 20 (array limit)
	bgt return		//if greater than, return
	ldr r4, =_array		//load array into r4
	ldr r5, [r4, r6]	//load element into r5
	add r6, r6, #4		//increment counter by 4
	cmp r5, r1		//compare current element with min
	blt min			//if less than min, branch
greater:
	cmp r5, r2		//compare current element with max
	bgt max			//if greater than max, branch
	bal _minMax		//branch always to loop

min:
	mov r1, r5		//assign current element to r1 (min)
	bal greater		//continue to check greater

max:
	mov r2, r5		//assign current element to r2 (max)
	bal _minMax		//branch always to loop
return:
	mov pc, lr		//return statement

//search
_search:
	cmp r6, #20		//compare counter to 20 (string limit)
	bgt return		//return if greater than limit
	ldr r4, =_array		//load array into r4
	ldr r5, [r4, r6]	//load current element into
	add r6, r6, #4		//increment counter by 4
	cmp r5, r1		//check if current value is the one we are searching
	beq return		//if equal, return (has been found)
	add r2, r2, #1		//r2 is the position where element was found
	bal _search

//bubble sort
_bubble:
	cmp r6, #20
	beq restartB
	ldr r1, =_array
	ldr r2, [r1, r6]
	ldr r3, [r1, r4]
	cmp r2, r3
	bgt switch
continueB:
	add r6, r6, #4
	add r4, r4, #4
	bal _bubble
switch:
	add r5, r5, #1
	str r2, [r1, r4]
	str r3, [r1, r6]
	bal continueB
restartB:
	cmp r5, #0
	beq return
	mov r5, #0
	mov r6, #0
	mov r4, #4
	bal _bubble
//doubloon
_doubloon:
	cmp r6, #3
	beq return			//return if r6 counter reaches string limit
	cmp r4, #4
	beq restartD			//branch to restartD if r4 counter reaches string limit
	ldrb r2, [r1, r6]		//load into r2 character to compare through
	cmp r2, #0
	beq next			//if r2 is 0 it means it's a character already checked
	ldrb r3, [r1, r4]		//load into r3 characters to the right of r2
	cmp r2, r3			//if a character is repeated
	beq equal			//branch to equal
continueD:
	add r4, r4, #1			//increment r4 counter to compare r2 to the next character
	bal _doubloon			//branch loop
equal:
	mov r0, #0
	add r8, r8, #1
	add r5, r5, #1			//when a char repeats r5 is the way to know it happened
	strb r0, [r1, r4]		//assign 0 to a character that is repeated
	bal continueD			//branch to increment r4 counter position
restartD:
	cmp r5, #1			//r5 should be 1 if a char appears just twice
	bne not_doubloon		//if not return since string if not doubloon
	mov r5, #0			//restart r5 into 0
	add r6, r6, #1			//increment r6 counter
	add r4, r6, #1			//increment r4 to the position to the right of r6
	bal _doubloon			//branch loop
next:					//r2 was 0, meaning it has already been checked
	add r6, r6, #1			//increment r6 to check next char
	add r4, r6, #1			//increment r4 to the position to the right of r6
	bal _doubloon			//branch loop
not_doubloon:
	mov r9, #1
	bal return
CheckDoub:
	cmp r9, #0
	bne NotD
	beq D
NotD:
	ldr r0, =_PNdoubloon
	bal return
D:
	ldr r0, =_Pdoubloon
	bal return
to_lower:
	cmp r2, #4			//compares counter to 4
	beq _doubloon			//if greater return

	ldrb r0, [r1, r2]		//addition of counter and string

	cmp r0, #65			//compares ASCII character to 65
	blt counter			//if less than = non alphabetical

	cmp r0, #90			//compares to 90
	bgt counter			//if greater than = lowercase or non alphabetical

	eor r0, r0, #0x20		//xors the chracter with a mask
	strb r0, [r1, r2]		//writes the character back to the string
	bal counter			//always branches to counter

counter:
	add r2, r2, #1			//increments counter by 1
	bal to_lower			//always bracnhes to to_lower