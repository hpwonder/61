;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;05/13/2015
;
;Lab08
;Exercise 1
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	
	LD R0, INPUT_ARRAY
	LD R1, GET_STR_SUB
	JSRR R1
	
	
	LD R0, INPUT_ARRAY ;print out
	PUTS

HALT
;----------
;Local data 
;----------
GET_STR_SUB .FILL x3200
IS_PAL .FILL x3800
INPUT_ARRAY .FILL x3400

;-------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R0): Address to store a string at
; Postcondition: The subroutine has allowed the user to input a string,
; terminated by the [ENTER] key, has converted the string
; to upper­case, and has stored it in a null­terminated array that
; starts at (R0).
; Return Value: R0 ← The address of the now upper case string
;-------------------------------------------
;------BEGIN SUBROUTINE::GET_STRING---------
.ORIG x3200

ST R1, R1_3200
ST R2, R2_3200
ST R3, R3_3200
ST R4, R4_3200
ST R6, R6_3200
ST R7, R7_3200
LD R3, UPPERCASE

AND R5, R5, #0 ;set R5 to 0
ADD R6, R6, R0 ;store address into R6

INPUT_LOOP	
	GETC
	OUT

	LD R4, ENTER ;check for enter
		ADD R4, R4, R0
		BRz	DONE_INPUT	
	AND R0, R0, R3
	STR R0, R6, #0 ;stores to address at register 6
	ADD R6, R6, #1 ;Increment the register
	ADD R5, R5, #1 ;increment counter for NUM characters
	BRnzp INPUT_LOOP
	
	DONE_INPUT
	
	;TERMINATE THE ARRAY WITH A 0
	AND R3, R3, #0
	STR R6, R3, #0

	;convert to upper case

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
UPPERCASE .FILL x5F
ENTER .FILL #-10
;-------------------------------------------
.ORIG x3400
.BLKW #100
