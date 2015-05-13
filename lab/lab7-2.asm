;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;05/13/2015
;
;Lab07
;Exercise 2
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	
	LD R0, INPUT_ARRAY
	LD R1, GET_STR_SUB
	JSRR R1
	
	LD R6, INPUT_ARRAY
	LD R1, IS_PAL
	JSRR R1
	
	ADD R4, R4, #0
	BRp PRINTYES
	BRz PRINTNO

			PRINTYES
			LEA R0, YES
			PUTS
			HALT

			PRINTNO
			LEA R0, NO
			PUTS
			HALT


;----------
;Local data 
;----------
YES .STRINGZ "This is a palidrome! \n"
NO .STRINGZ "This is a NOT palidrome! \n"
GET_STR_SUB .FILL x3200
IS_PAL .FILL x3800
INPUT_ARRAY .FILL x3400
;-------------------------------------------
;------BEGIN SUBROUTINE::GET_STRING---------
.ORIG x3200

ST R1, R1_3200
ST R2, R2_3200
ST R3, R3_3200
ST R4, R4_3200
ST R6, R6_3200
ST R7, R7_3200

AND R5, R5, #0 ;set R5 to 0
ADD R6, R6, R0 ;store address into R6

INPUT_LOOP	
	GETC
	OUT

	LD R4, ENTER ;check for enter
		ADD R4, R4, R0
		BRz	DONE_INPUT	
	STR R0, R6, #0 ;stores to address at register 6
	ADD R6, R6, #1 ;Increment the register
	ADD R5, R5, #1 ;increment counter for NUM characters
	BRnzp INPUT_LOOP
	
	DONE_INPUT
	
	;TERMINATE THE ARRAY WITH A 0
	AND R3, R3, #0
	STR R6, R3, #0

	LD R1, R1_3200
	LD R2, R2_3200
	LD R3, R3_3200
	LD R4, R4_3200
	LD R6, R6_3200
	LD R7, R7_3200

	RET
;----------
R1_3200 .BLKW #1
R2_3200 .BLKW #1
R3_3200 .BLKW #1
R4_3200 .BLKW #1
R6_3200 .BLKW #1
R7_3200 .BLKW #1
ENTER .FILL #-10
;------------------------------------------
;-------BEGIN SUBROUTINE::IS_PALIDROME-------
.ORIG x3800
ST R7, R7_3800
	;R5 currently has num chars
	;R6 currently has address of string
	;we will use r1 for first char
	;we will use r2 for seccond char
	ADD R5, R5, #-1;subtract 1 from R5
	AND R4, R4, #0 ;set r4 into 0
	ADD R4, R6, #0 ;load address into r4
	ADD R4, R6, R5 ;increment R4 to end of the array

	COMPARE
		AND R3, R3, #0 ;set r3 to 0

		LDR R1, R6, #0 ;load first char into r1
		LDR R2, R4, #0 ;load last char into r2
		NOT R1, R1
		ADD R1, R1, #1
		ADD R3, R1, R2 ;store into r3, r1 and -r2
		BRnp NOT_PALI ;if result is pos or neg, it is not a pali
		
		ADD R6, R6, #1 ;next letter
		ADD R4, R4, #-1 ;next letter

		ADD R5, R5, #-1 ;char counter
		BRz YES_PALI
		
		BRnzp COMPARE

	NOT_PALI
		LD R4, INVALIDPALI
		LD R7, R7_3800
RET
	
	YES_PALI
	LD R4, VALIDPALI
	LD R7, R7_3800
RET
;----------
R7_3800 .BLKW #1
INVALIDPALI .FILL #0
VALIDPALI .FILL #1
.END
;-------------------------------------------
.ORIG x3400
.BLKW #100
