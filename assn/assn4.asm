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
LD R0, introMessage  ; Output Intro Message
PUTS

BEGIN
	GETC
	OUT
	
  LD R5, NEGATIVE
		NOT R5, R5
		ADD R5, R5, #1

		ADD R5, R5, #0
	BRz negINPUT

	LD R5, POSITIVE
		NOT R5, R5
		ADD R5, R5, #1

		ADD R5, R5, #0
	BRz posINPUT

	
	LOOPINPUT
		GETC
		OUT
	ENDINPUT

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

