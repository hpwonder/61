;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;05/13/2015
;
;Lab08
;Exercise 2
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	
	;LD R0, PRINT_OP_CODES ;print out
	;JSRR R0

;HALT
;----------
;Local data 
;----------
PRINT_OP_CODES .FILL x3200
;-------------------------------------------
;------BEGIN SUBROUTINE::PRINT_OP_CODES---------
.ORIG x3200

ST R1, R1_3200
ST R2, R2_3200
ST R3, R3_3200
ST R4, R4_3200
ST R6, R6_3200
ST R7, R7_3200
LD R5, PRINT_OP_NUM
LD R4, PRINT_OP_NAME

OUTERLOOP
PRINTLOOP
	LDR R0, R4, #0
	BRz NEXT_OP
	BRn DONE_OP
	OUT
	ADD R4, R4, #1
	BRnzp PRINTLOOP

	NEXT_OP
		ADD R4, R4, #1
		LEA R0, EQUAL
		PUTS

		LDR R1, R5, #0
		CONVERTTOBINARY
	;--------------------------------------======================
								LD R3, sCOUNTER

								OUTERLOOP
								LD R2, bCOUNTER			;Inside outerloop because counter needs to be reset

								MAINLOOP
								ADD R1, R1, #0 			;enable Br comparison
								BRzp POS 						;Positive number
								BRn NEG

								NEG
									LEA	R0, OUT0
									PUTS
									BRzp AFTERLOOP

								POS
									LEA R0, OUT1
									PUTS

								AFTERLOOP
								
								ADD R1, R1, R1		;Left shift by doubling value in R1
								ADD R2, R2, #-1		;Reduce counter by 1
                
								BRp MAINLOOP			;
								BRz ADDSPACE			;

								ADDSPACE
								ADD R3, R3, #0
								BRz END
								LEA R0, SPACE
								PUTS
								
								ADD R3, R3, #-1
								BRzp OUTERLOOP
																	;Last 4 bits

								END
								LEA R0, NEWLINE2
								PUTS


	;--------------------------------------======================	
		ADD R5, R5, #1
		LEA R0, NEWLINE
		PUTS
	BRnzp PRINTLOOP

DONE_OP

LD R1, R1_3200
LD R2, R2_3200
LD R3, R3_3200
LD R4, R4_3200
LD R6, R6_3200
LD R7, R7_3200
HALT
;RET
;----------
R1_3200 .BLKW #1
R2_3200 .BLKW #1
R3_3200 .BLKW #1
R4_3200 .BLKW #1
R6_3200 .BLKW #1
R7_3200 .BLKW #1
PRINT_OP_NAME .FILL x3600
PRINT_OP_NUM .FILL x3800
EQUAL .STRINGZ " = "
NEWLINE .STRINGZ "\n"
OUT1 .STRINGZ "0"
OUT0 .STRINGZ "1"
bCOUNTER .FILL #4
sCOUNTER .FILL #3						  ;for spaces (end must be terminated with newline)
SPACE 		.STRINGZ " "
NEWLINE2 .STRINGZ "\n"
STR_PTR .FILL x3600
NUM_PTR .FILL x3800
;----------------------------------------------------------------

;-----------------------------------------------------------------------------
.ORIG x3600
	BROP .stringz "BR" ;0
	ADDOP .stringz "ADD" ;1
	LDOP .stringz "LD" ;2
	STOP .stringz "ST" ;3
	JSROP .stringz "JSR" ;4
	JSRROP .stringz "JSRR" ;4
	ANDOP .stringz "AND" ;5
	LDROP .stringz "LDR" ;6
	STROP .stringz "STR" ;7
	RTIOP .stringz "RTI" ;8
	NOTOP .stringz "NOT" ;9
	LDIOP .stringz "LDI" ;10
	STIOP .stringz "STI" ;11
	JMPOP .stringz "JMP" ;12
	RETOP .stringz "RET" ;12
	LEAOP .stringz "LEA" ;14
	TRAPOP .stringz "TRAP" ;15
	ENDFLAG .FILL #-1

.ORIG x3800
	BRNUM .FILL #0
	ADDNUM .FILL #1
	LDNUM .FILL #2
	STNUM .FILL #3
	JSRNUM .FILL #4
	JSRRNUM .FILL #4
	ANDNUM .FILL #5
	LDRNUM .FILL #6
	STRNUM .FILL #7
	RTINUM .FILL #8
	NOTNUM .FILL #9
	LDINUM .FILL #10
	STINUM .FILL #11
	RETNUM .FILL #12
	JMPNUM .FILL #12
	LEANUM .FILL #14
	TRAPNUM .FILL #15
.END
