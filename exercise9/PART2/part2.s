	.text
	.global _start

_start:   
		LDR 	R1, =0xFF200000		// LEDR Port	
		LDR 	R8, =LIST		//R8 gets size of list
		LDR 	R2, [R8]			// make a register that stores value of list size (first value in list)
		ADD 	R8, #4			//R8 moves to first index in list
		MOV 	R5, #0			// counts number of words iterated
		LDR 	R9, =0xFF200050		// R9 is the key
		

DISPLAY:  
	CMP 	R5,R2		//compare number of words iterated to total number of words
	BEQ 	REVERSE_DISPLAY
	LDR 	R6,=200 		// Delay counter
	LDR 	R11,[R8]
	STR 	R11,[R1]		//light up LEDR
	LDR 	R10, [R9]	//read keys
	CMP 	R10,#0		//compare, see if equals 0 or 1
	BNE 	KEYRESTART	//restart loop if key is pressed

	BL 	DELAY
	
	ADD 	R5,#1
	ADD 	R8, #4		//next word in list
	B 	DISPLAY

REVERSE_DISPLAY:
	CMP 	R5,#0		//compare number of words iterated to total number of words
	BEQ 	DISPLAY

	LDR 	R6,=200		// Delay counter
	LDR 	R11,[R8]
	STR 	R11,[R1]		//light up LEDR
	SUB 	R8, #4		//previous word in list
	SUB 	R5,#1

	LDR 	R10, [R9]		//read keys
	CMP 	R10,#0		//compare, see if equals 0 or 1 depending on what means key is on
	BNE 	KEYRESTART	//restart loop if key is pressed

	BL 	DELAY
	B	REVERSE_DISPLAY


KEYRESTART:

	LDR 	R8, =LIST			//R8 gets size of list
	ADD 	R8, #4			//R8 moves to first index in list
MOV 	R5, #0			// counts number of words iterated	
	LDR 	R10, [R9]		//read keys
	CMP 	R10,#0		//compare, see if equals 0 or 1 depending on what means key is on
	BNE 	DISPLAY
	B 	KEYRESTART
	

DELAY:
	SUB 	R6,#1			//-1 per iteration
	CMP		R6,#0			//when not equal to zero, repeat
	BNE 	DELAY
	MOV		PC,LR
	
LIST:	.word	8,01,02,04,8,16,32,64,128
		.end