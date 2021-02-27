	.text
	//.global _start
	.global main
	.extern printf
	.global _array
	.global _min
	.global _max
	.global _Pminmax
	.global _Psearch
	.global _Parray
	.global _string
	.global _Pdoubloon
	.global _PNdoubloon

//ARGUMENTS
//_start:
main:
	//minMax arguments
	mov r1, #0xFF		//initialize r1 with FF as the min
	mov r2, #0		//initialize r2 with 0 as the max
	mov r6, #0		//initialize r6 with 0 as counter
	bl _minMax		//branch to minMax with a link
	//printminMax
	ldr r0, =_Pminmax
	bl printf

	//search arguments
	mov r3, #0
	mov r2, #0
	mov r1, #5		//the value stored in r1 is the value to search
	mov r5, #0
	mov r4, #0
	mov r6, #0		//counter
	bl _search
	//printsearch
	ldr r0, =_Psearch
	bl printf

	//fill registers for array
	ldr r8, =_array
        ldr r1, [r8, #0]
        ldr r2, [r8, #4]
        ldr r3, [r8, #8]
        ldr r4, [r8, #12]
        ldr r5, [r8, #16]
        ldr r6, [r8, #20]
        stmfd sp!, {r4-r6}
	//array
	ldr r0, =_Parray
	bl printf

	//bubble sort arguments
	mov r0, #0
	mov r2, #0		//left element
	mov r3, #0		//right element
	mov r4, #4		//position for right
	mov r5, #0		//counter
	mov r6, #0		//position for left
	bl _bubble

	//fill registers for array
	ldr r8, =_array
        ldr r1, [r8, #0]
        ldr r2, [r8, #4]
        ldr r3, [r8, #8]
        ldr r4, [r8, #12]
        ldr r5, [r8, #16]
        ldr r6, [r8, #20]
        stmfd sp!, {r4-r6}
	//printarray
	ldr r0, =_Parray
	bl printf

	//printstring
	ldr r0, =_string
	bl printf

	//doubloon arguments
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov r3, #0
	mov r4, #1
	mov r5, #0
	mov r6, #0
	ldr r1, =_string
	bl to_lower

	//printdoubloon
	bl CheckDoub
	bl printf
_exit:
	mov r7, #1
	swi 0
//DATA
.data
_array:
	.word 3, 6, 7, 5, 2, 10
_min:
	.int 0
_max:
	.int 0
_Pminmax:
	.asciz "Min is: %d, Max is: %d\n"
_Psearch:
	.asciz "Value: %d, Found in position: %d\n"
_Parray:
	.asciz "Array: %d, %d, %d, %d, %d, %d\n"
_string:
	.asciz "Abba\n"
_Pdoubloon:
	.asciz "Is doubloon\n"
_PNdoubloon:
	.asciz "Is not doubloon\n"
