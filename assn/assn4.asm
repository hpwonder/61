;=================================================
; 
; Name: Chuanping Fan
; Username: cfan002@ucr.edu
;	
; SID: 861105608
; Assignment name: assn 4
; Lab section: 029
; TA: Jose
;
; I hereby certify that I have not received 
; assistance on this assignment, or used code
; from ANY outside source other than the
; instruction team. 
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;-------------------------------
;INSERT CODE STARTING FROM HERE 
;--------------------------------
;TO Output Intro Message
VERYBEGIN
;NOTE::::::: Don't Forget to check for + - after first char!!!!!!
LD R6, ZERO
LD R0, introMessage  ; Output Intro Message
PUTS

LEA R0, NEWLINE
PUTS

BEGIN
	GETC
	OUT

  LD R5, NEGATIVE ; Check if -
		NOT R5, R5
		ADD R5, R5, #1

		ADD R5, R5, R0
		BRz negINPUT

	LD R5, POSITIVE ;Check if +
		NOT R5, R5
		ADD R5, R5, #1

		ADD R5, R5, R0
		
	
	NUMBERSONLY
		LD R5, negASCII ;check for non-numerical
			ADD R5, R5, R0
			BRn INVALID1
		LD R5, posASCII ;^ (after 57 ascii)
			ADD R5, R5, R0
			BRp INVALID1
		LD R5, ENTER ;check for enter
			ADD R5, R5, R0
			BRz	ENDPROG

		GETC
		OUT
	BR NUMBERSONLY	
	END_INPUTLOOP
	
	STARTCONV

	INVALID1
		LEA R0, NEWLINE
		PUTS
		LD R0, errorMessage
		PUTS
		BR VERYBEGIN
	negINPUT
		ADD R6, R6, #1
		BR NUMBERSONLY

ENDPROG
HALT
;---------------	
;Data
;---------------

arraybegin .FILL x4000
introMessage .FILL x6000
errorMessage .FILL x6100
ZERO .FILL #0
NEGATIVE .FILL #45
POSITIVE .FILL #43
NEWLINE .STRINGZ "\n"
CHECKNUM .FILL #9
negASCII .FILL #-48
posASCII .FILL #-58
ENTER .FILL #-10
;------------
;Array
;------------
.ORIG x4000
;------------
;Remote data
;------------
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_mes .STRINGZ	"ERROR INVALID INPUT\n"
;---------------
;END of PROGRAM
;---------------
.END
;-------------------
;PURPOSE of PROGRAM
;-------------------

