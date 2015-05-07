;=================================================
; 
; Name: <last name, first name>
; Username:
;
; SID:
; Assignment name: <assn ?>
; Lab section: 
; TA: 
;
; I hereby certify that I have not receieved 
; assistance on this assignment, or used code,
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


HALT
;---------------	
;Data
;---------------
TIMES .STRINGZ " * "
EQUALS .STRINGZ " = "
OVERFLOW .STRINGZ "Overflow!"




;------------
;Remote data
;------------

;-------------------
; Subroutine to get input from user and store value in R1
;-------------------
.ORIG x3200
;HINT back up your registers


;Example of how to output Intro Message
;LD R0, introMessagePtr
;PUTS

;Eaxmple of how to output Error Message
;LD R0, errorMessagePtr
;PUTS


;HINT Restore your registers

;Data for subroutine:
introMessagePtr .FILL x6000
errorMessagePtr .FILL x6100


;-------------------
; Subroutine to multiply two numbers in Register x and Register y,
; and store product into Register z
;-------------------
.ORIG x3400
;HINT back up your registers

;HINT Restore your registers

;Data for subroutine:


;-------------------
; Subroutine to ouput number in Register x
;-------------------
.ORIG x3800
;HINT back up your registers

;HINT Restore your registers

;Data for subroutine:



.ORIG x6000
;---------------
;Initial prompt (IntroMessagePtr points here)
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;Error message (ErrorMessagePtr points here)
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

