.section init
.global _start

//values
.equ FSEL1,  0x3f200004
.equ FSEL2,  0x3f200008
.equ SET0,   0x3f20001C
.equ CLR0,   0x3f200028
.equ LEV0,   0x3f200034
.equ DELAY,  0x3F0000

_start:
// configure GPIO 10 for input
ldr r0, =FSEL1
mov r1, #0
str r1, [r0]

// configure GPIO 20 for output
ldr r0, =FSEL2
mov r1, #1
str r1, [r0]

// bit 17
mov r2, #(1<<10)

// bit 20
mov r3, #(1<<20)

loop:
    // read GPIO 10 
    ldr r0, =LEV0
    ldr r1, [r0] 
    tst r1, r2
    beq on // when the button is pressed (goes LOW), turn on LED
    
    // set GPIO 20 low
    off:
        ldr r0, =CLR0
        str r3, [r0]
    bal loop

    // set GPIO 20 high
    on:
        ldr r0, =SET0
        str r3, [r0]

        // delay
        mov r4, #DELAY
        wait:
        subs r4, #1
        bne wait

    bal loop

