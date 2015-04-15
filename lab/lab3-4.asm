;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;04/15/2015
;
;Lab03
;Exercise 4
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LEA R0, PROMPT
	PUTS
	LD R1, COUNTER ; load the counter
	LD R2, DATA_PTR ; load location of the array
	GETIN
		GETC
		STR R0, R2, #0
		ADD R2, R2, #1
		ADD R1, R1, #1
		
		LD R5, ENTER
		NOT R5, R5
		ADD R5, R5, #1

		ADD R5, R5, R0
	BRz ENDLOOP
	BRnp GETIN

	ENDLOOP

	LEA R0, PROMPT2
	LD R2, DATA_PTR;
	PUTS

	PRINT
		LDR R0, R2, #0
		OUT

		LEA R0, NEWL
		PUTS
		
		ADD R2, R2, #1
		ADD R1, R1, #-1
	BRp PRINT
 	
	ENDPROG
	HALT

;----------
;Local data 
;----------
	NEWL .STRINGZ "\n"
	PROMPT .STRINGZ "Enter 10 numbers 0-9 \n"
	PROMPT2 .STRINGZ "Your inputs are \n"
	DATA_PTR .FILL x4000 ;Label called DATA_PTR that refers to the address x4000
	COUNTER .FILL #0
	ENTER .FILL #10 ; newline char/enter key
;------ Array ------
.ORIG x4000
.END

