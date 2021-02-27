	.text
	.global _write			//making _write global
	.global _read			//making _read global
//procedures
_write:
	mov r7, #4			//calls linux sys write command
	mov r0, #1			//writes to terminal
	swi 0				//switches to supervisor mode
	mov pc, lr			//return
_read:
	mov r7, #3			//calls linux sys read command
	mov r0, #0			//reads from keyboard
	swi 0				//switches to supervisor mode
	mov pc, lr			//return
