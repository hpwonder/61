;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;Lab Section 026
;
;Assignment 2
;Created: 4/8/15
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LEA R0, USER_PROMPT ;Load user prompt
	LD R7, ASCII
	LD R6, ASCIIp
	PUTS ;Output

	GETC
	OUT
	ADD R1, R0, #0 ; put Value from 0(input) to Register 1

	LEA R0, NEWLINE; NEWLINE
	PUTS

	GETC
	OUT
	ADD R2, R0, #0 ; put Value from 0(input) to Register 2

	LEA R0, NEWLINE; NEWLINE
	PUTS


	;DISPLAY STUFF==============
	ADD R0, R1, #0
	OUT

	LEA R0, MINUS ; -
	PUTS

	ADD R0, R2, #0
	OUT

	LEA R0, EQUALS ; =
	PUTS
	;DISPLAY STUfF===============
	ADD R1, R1, R7 ; convert to decimal
	ADD R2, R2, R7 ; convert to decimal

	NOT R2, R2 ;inverts number in R2 and loads it in R2
	ADD R2, R2, #1
	
	ADD R0, R1, R2 ; ; Do summation
	BRn NEGATIVENUM
	ADD R0, R0, R6 ; Convert back to ascii
	OUT
	HALT

	NEGATIVENUM
		LEA R0, NEGATIVE ; indicates negative number
		PUTS
		ADD R0, R1, R2 ; ; Do summation
		NOT R0, R0
		ADD R0, R0, #1
		ADD R0, R0, R6 ; Convert back to ascii
		OUT	

		HALT
;----------
;Local data 
;----------
	USER_PROMPT .STRINGZ "ENTER two numbers: \n"
	NEWLINE .STRINGZ "\n"
	MINUS .STRINGZ " - "
	EQUALS .STRINGZ " = "
	NEGATIVE .STRINGZ "-"
	ASCII .fill #-48
	ASCIIp .fill #48
.END

