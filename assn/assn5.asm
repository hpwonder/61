;=================================================
; 
; Name: <Fan, Chuanping>
; Username: cfan002
;
; SID: 861105608
; Assignment name: <assn 5>
; Lab section: 
; TA: Jose
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

LD R0, GET_INPUT ;enter subroutine GET_INPUT
JSRR R0
ADD R2, R1, #0

LD R0, GET_INPUT ;enter subroutine GET_INPUT
JSRR R0

LD R0, MULT_OP ;enter subroutine MULT_OP
JSRR R0

LD R6, PRODFLAG ;keeps track of how many negative signs were entered

;========first number
LD R4, SETTOZERO
ADD R4, R2, #0
LD R0, PRINT_REG
JSRR R0
;========= *
LEA R0, TIMES
PUTS
;========= second number
LD R4, SETTOZERO
ADD R4, R1, #0
LD R0, PRINT_REG
JSRR R0
;==========  =
LEA R0, EQUALS
PUTS
;========== Product
LD R0, SETTOZERO
ADD R0, R6, #0
BRnp PRINTPRODUCT
	NOT R3, R3 
	ADD R3, R3, #1

PRINTPRODUCT
LD R4, SETTOZERO
ADD R4, R3, #0
LD R0, PRINT_REG
JSRR R0

LEA R0, NEWL
PUTS

HALT
;---------------	
;Data
;---------------
SETTOZERO .FILL #0
TIMES .STRINGZ " * "
EQUALS .STRINGZ " = "
OVERFLOW .STRINGZ "Overflow!"
NEWL .STRINGZ "\n"
GET_INPUT .FILL x3200
MULT_OP .FiLL x3400
PRINT_REG .FILL x3800
PRODFLAG .FILL #-1 ;-1 = 1 negative sign, 0 = 1, 1 = 2
;------------
;Remote data
;------------

;-------------------
; Subroutine to get input from user and store value in R1
;-------------------
.ORIG x3200
BEGIN_GET_INPUT
ST R0, R0_3200
ST R2, R2_3200
ST R3, R3_3200
ST R4, R4_3200
ST R5, R5_3200
ST R6, R6_3200
ST R7, R7_3200

GET_INPUT_START

LD R1, ZERO ;Initialize final register to 0
LD R2, ZERO ; used as a temp
LD R3, arraybegin ; outer counter
LD R4, ZERO ; inner counter
LD R5, TEN  ; counter for multiplying by 10
LD R6, ZERO ; NEGATIVE FLAG
LD R0, introMessage  ; Output Intro Message
PUTS

	BEGIN
	GETC
	OUT

	LD R5, NEGATIVE ; Check if -
	ADD R5, R5, R0
	BRz negINPUT
								
	LD R5, POSITIVE ;Check if +
	ADD R5, R5, R0
		BRz FIRSTSKIP
	LD R5, ENTER ;check for enter
	ADD R5, R5, R0
		BRz INVALID1
																		
	NUMBERSONLY
		LD R5, ENTER ;check for enter
		ADD R5, R5, R0
		BRz	LOADSTASH
	LD R5, negASCII ;check for non-numerical
		ADD R5, R5, R0
		BRn INVALID1
	LD R5, posASCII ;^ (after 57 ascii)
		ADD R5, R5, R0
		BRp INVALID1
																																											
	ADDDEC ;take number, convert into decimal and store into array
		LD R5, negASCII
		ADD R0, R0, R5 ;convert input from ascii char into dec
		STR R0, R3, #0 ;store digit into array
		ADD R3, R3, #1 ;Increment array
		ADD R4, R4, #1 ;increment number of elements in array (decimal places)
	ENDDEC		
	
	FIRSTSKIP ;jump here if + or - is detected, otherwise would have been checked twice
	GETC
	OUT
	BR NUMBERSONLY	
	
LOADSTASH
LD R3, arraybegin ;set array back to beginning
	OUTERLOOP
		LD R5, ZERO ; reset
		LDR R0, R3, #0 ;put current value of array into R3
		ADD R5, R0, #0 ; Copy it into R5
		ADD R2, R4, #0 ;copy r4 into r2
		ADD R2, R2, #-1 ;subtract 1 from 10^
		BRz ONESDIGIT
		RELOAD ;multiply by another set of 10
		INNERLOOP	;multiply by 10
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			LD R5, ZERO
			ADD R5, R0, #0 ;next digit
			ADD R2, R2, #-1
			BRp RELOAD
		ONESDIGIT
			ADD R1, R1, R0
			ADD R3, R3, #1 ;increment array
			ADD R4, R4, #-1 ;decrease elements left in array
			BRp OUTERLOOP

ADD R6, R6, #0
	BRp NEGFLAG
	BR ENDPROG

	INVALID1
		;LEA R0, NEWLINE
		;PUTS
		LD R0, errorMessage
		PUTS
		BR GET_INPUT_START
	negINPUT ;negative detected, waiting for first number
		ADD R6, R6, #1
		BR FIRSTSKIP 
	NEGFLAG
		NOT R1, R1
		ADD R1, R1, #1
	
ENDPROG

LD R0, R0_3200
LD R2, R2_3200
LD R3, R3_3200
LD R4, R4_3200
LD R5, R5_3200
LD R6, R6_3200
LD R7, R7_3200

RET

R0_3200 .BLKW #1
R2_3200 .BLKW #1
R3_3200 .BLKW #1
R4_3200 .BLKW #1
R5_3200 .BLKW #1
R6_3200 .BLKW #1
R7_3200 .BLKW #1


arraybegin .FILL x4000
introMessage .FILL x6000
errorMessage .FILL x6100
ZERO .FILL #0
NEGATIVE .FILL #-45
POSITIVE .FILL #-43
NEWLINE .STRINGZ "\n"
CHECKNUM .FILL #9
negASCII .FILL #-48
posASCII .FILL #-58
ENTER .FILL #-10
TEN .FILL #10

;------------
.ORIG x4000 ;Array starts here
;------------
;Remote data
;------------
;-------------------------------------------------------
; Subroutine to multiply two numbers in Register x and Register y,
; and store product into Register z
;-------------------------------------------------------
.ORIG x3400
BEGIN_MULT_OP
ST R0, R0_3400
ST R1, R1_3400
ST R2, R2_3400
ST R4, R4_3400
ST R5, R5_3400
ST R6, R6_3400
ST R7, R7_3400

LD R5, RESETR
LD R4, RESETR
LD R3, RESETR
;====ABS val both numbers so we can do standard mult with addition
ABS1
ADD R5, R1, #0 ;copy r1 to r5 and abs value
BRz ITISZERO
BRp ABS2
	NOT R5, R5
	ADD R5, R5, #1

ABS2
ADD R4, R2, #0 ;copy r2 to r4 and abs value
BRz ITISZERO
BRp CHECKSWAP
	NOT R4, R4
	ADD R4, R4, #1

;====find out which number is smaller so we can do efficient mult
CHECKSWAP
LD R0, RESETR ;set r0 to 0
NOT R5, R5
ADD R5, R5, #1 ;temp convert r5 into neg
ADD R0, R4, R5
BRnz NEGORZERO ; R5 is bigger than R4 or the same
	SWAP ;R4 is bigger than R5 so we need to swap the two
	NOT R5, R5
	ADD R5, R5, #1 ;REST R5 to original abs val of r1
	LD R0, RESETR
	ADD R0, R4, #0
	LD R4, RESETR
	ADD R4, R5, #0
	LD R5, RESETR
	ADD R5, R0, #0
	BRnzp MULTWHILE
NEGORZERO
	NOT R5, R5
	ADD R5, R5, #1 ;REST R5 to original abs val of r1
;====main multiplication loop
MULTWHILE
	ADD R3, R3, R5
	ADD R4, R4, #-1
BRp MULTWHILE

RESTORE
LD R0, R0_3400
LD R1, R1_3400
LD R2, R2_3400
LD R4, R4_3400
LD R5, R5_3400
LD R6, R6_3400
LD R7, R7_3400

RET

ITISZERO
LD R3, RESETR ;one of the multipliers is 0, so product is 0
BRnzp RESTORE
;---------------
RESETR .FILL #0
R0_3400 .BLKW #1
R1_3400 .BLKW #1
R2_3400 .BLKW #1
R4_3400 .BLKW #1
R5_3400 .BLKW #1
R6_3400 .BLKW #1
R7_3400 .BLKW #1
;-------------------------------------------------------
; Subroutine to ouput number in Register x
;-------------------------------------------------------
.ORIG x3800
ST R0, R0_3800
ST R1, R1_3800
ST R2, R2_3800
ST R3, R3_3800
ST R5, R5_3800
ST R7, R7_3800
;R1, currently has input 1
;R2, currently has input 2
;R3, currently has product
;R4, currently has numer to "decode"
;R5, currently holds the current digit we are looking at
;R6, currently keeps track of how many negatives there are

LD R5, CHECKZER
ADD R5, R4, #0
BRp PRINTPOS;number is positive, print an +
Brn PRINTNEG;number is negative, print a - 
BRz PRINTSTART;number is 0, print nothing
PRINTPOS
	LEA R0, POSprint
	PUTS
	BRnzp PRINTSTART
PRINTNEG
	ADD R6, R6, #1
	LEA R0, NEGprint
	PUTS
	NOT R4, R4
	ADD R4, R4, #1

PRINTSTART
	
	LD R1, CHECKZER ;set r1 to 0
	TENTHOUS
		LD R5, NEGTENT ;set r5 to -10000
		ADD R4, R4, R5 ;subtract num from 10000
		BRn UNDOTENT ;if it goes into negatives, undo it
			ADD R1, R1, #1 ;else add 1 to digit counter
			BRnzp TENTHOUS
		UNDOTENT
			LD R5, POSTENT ;add 10000 back in
			ADD R4, R4, R5
			BRnzp PRINTTENTHOUS
		PRINTTENTHOUS
			LD R0, CHECKZER ;set r1 to 0
			LD R5, PRINTCONVERT; load ascii conversion into r5
			ADD R0, R1, #0
			ADD R0, R0, R5 
		 	OUT							;print
	
	LD R1, CHECKZER
	THOUS
		LD R5, NEGT
		ADD R4, R4, R5
		BRn UNDOT
			ADD R1, R1, #1 ;else add 1 to digit
			BRnzp THOUS
		UNDOT
			LD R5, POST
			ADD R4, R4, R5
			BRnzp PRINTTHOUS
		PRINTTHOUS
			LD R0, CHECKZER
			LD R5, PRINTCONVERT
			ADD R0, R1, #0
			ADD R0, R0, R5 ;convert from ascii to dec
		 	OUT

	LD R1, CHECKZER
	HUNDRED
		LD R5, NEGHUNDRED ;load -100
		ADD R4, R4, R5 ;subtract 100 from total
		BRn UNDOHUNDRED
			ADD R1, R1, #1 ;else add 1 to digit
			BRnzp HUNDRED ;go back and do it again if not negative
		UNDOHUNDRED
			LD R5, POSHUNDRED ;went into negatives, lets add it back in
			ADD R4, R4, R5
			BRnzp PRINTHUNDRED
		PRINTHUNDRED
			LD R0, CHECKZER
			LD R5, PRINTCONVERT
			ADD R0, R1, #0
			ADD R0, R0, R5 ;convert from ascii to dec
		 	OUT
	
	LD R1, CHECKZER
	TENS
		LD R5, NEGTEN ;load -10
		ADD R4, R4, R5
		BRn UNDOH
			ADD R1, R1, #1 ;else add 1 to digit
			BRnzp TENS 
		UNDOH
			LD R5, POSTEN ;load +10
			ADD R4, R4, R5
			BRnzp PRINTTEN
		PRINTTEN
			LD R0, CHECKZER
			LD R5, PRINTCONVERT
			ADD R0, R1, #0
			ADD R0, R0, R5 ;convert from ascii to dec
		 	OUT

	LD R1, CHECKZER
	ONES
		LD R5, NEGUNO
		ADD R4, R4, R5
		BRn UNDOUNO
			ADD R1, R1, #1 ;else add 1 to digit
			BRnzp ONES
		UNDOUNO
			LD R5, POSUNO
			ADD R4, R4, R5
			BRnzp PRINTUNO
		PRINTUNO
			LD R0, CHECKZER
			LD R5, PRINTCONVERT
			ADD R0, R1, #0
			ADD R0, R0, R5 ;convert from ascii to dec
		 	OUT


LD R0, R0_3800
LD R1, R1_3800
LD R2, R2_3800
LD R3, R3_3800
LD R5, R5_3800
LD R7, R7_3800

RET
;Data for subroutine:
;--------------
CHECKZER .FILL #0
POSTENT .FILL #10000
NEGTENT .FILL #-10000
POST .FILL #1000
NEGT .FILL #-1000
POSHUNDRED .FILL #100
NEGHUNDRED .FILL #-100
POSTEN .FILL #10
NEGTEN .FILL #-10
POSUNO .FILL #1
NEGUNO .FILL #-1
PRINTCONVERT .FILL #48

NEGprint .STRINGZ "-"
POSprint .STRINGZ "+"
NEWLINEprint .STRINGZ "\n"

R0_3800 .BLKW #1
R1_3800 .BLKW #1
R2_3800 .BLKW #1
R3_3800 .BLKW #1
R4_3800 .BLKW #1
R5_3800 .BLKW #1
R7_3800 .BLKW #1
;--------------
.ORIG x6000
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
.ORIG x6100	
error_mes .STRINGZ	"ERROR INVALID INPUT\n"
;---------------
;END of PROGRAM
;---------------
.END
;-------------------
;PURPOSE of PROGRAM
;-------------------

