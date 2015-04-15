;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;04/15/2015
;
;Lab03
;Exercise 2
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LEA R0, PROMPT
	PUTS

	LD R1, COUNTER
	
	LD R2, DATA_PTR
	GETIN
		GETC
		STR R0, R2, #0
		ADD R2, R2, #1

		ADD R1, R1, #-1
	BRp GETIN
 	HALT

;----------
;Local data 
;----------
	PROMPT .STRINGZ "Enter 10 numbers 0-9 \n"
	DATA_PTR .FILL x4000 ;Label called DATA_PTR that refers to the address x4000
	COUNTER .FILL #10
;------ Array ------
.ORIG x4000

.END

