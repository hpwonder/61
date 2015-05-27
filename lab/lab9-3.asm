;=================================================
; 
; Name: Fan, Chuanping
; Username: cfan002@ucr.edu
;	
; SID: 861105608
; lab name: lab 9
; Lab section: 029
; TA: Jose
;
;=================================================

.ORIG x3000
;------------
;Initialize
;------------
INPUTLOOP
	LD R4, MULTSIGN ;identify the *
	GETC
	OUT
	ADD R4, R4, R0 ;found *
 	BRz MULTLEAVE

	LD R6, SUB_STACKPUSH
	JSRR R6
	
	LEA R0, NEWLINE
	PUTS
BR INPUTLOOP


MULTLEAVE ;found *
	LEA R0, NEWLINE
	PUTS
	LD R6, SUB_STACKMULT
	JSRR R6
	LD R6, SUB_STACKPOP
	JSRR R6
	
	AND R4, R4, #0
	ADD R4, R0, #0 
	
	LD R0, SUB_PRINT
	JSRR R0

HALT
;---------
NEWLINE .STRINGZ "\n"
MULTSIGN .FILL #-42
STACK_ADDRESS .FILL x3200
SUB_STACKPUSH .FILL x3800
SUB_STACKPOP .FILL x4000
SUB_STACKMULT .FILL x4200
SUB_PRINT .FILL x4800
;-------------------------------
;Stack Address 
;--------------------------------
.ORIG x3200
.BLKW #9
;-------------------------------
;SUB_STACK_PUSH 
;--------------------------------
.ORIG x3800
ST R7, R7_SAVE1
LD R1, STACK_BEGIN
LD R4, ASCIICONVERT

ADD R3, R3, #1;increment counter
ADD R6, R3, #-9
BRzp OVERFLOWDISP

ADD R2, R3, R1;add counter to array. this is the top element 
ADD R0, R0, R4
STR R0, R2, #0 ;push thing to top of the stack

LD R7, R7_SAVE1
RET

OVERFLOWDISP
LEA R0, OVERFLOW1
PUTS
LD R7, R7_SAVE1
RET

;------
ASCIICONVERT .FILL #-48
STACK_BEGIN .FILL x3200
R7_SAVE1 .BLKW #1
OVERFLOW1 .STRINGZ "OVERFLOW!\n"
;-------------------------------
;SUB_STACK_POP
;note: this sub routine does NOT remove the top of the stack, rather it decrements the pointer to the head. 
;This is because we can easily override the previous head value later and there is no reason to remove it.
;--------------------------------
.ORIG x4000
ST R7, R7_SAVE2
LD R1, STACK_BEGIN2

ADD R3, R3, #-1
BRn UNDERFLOWDISP

LDR R0, R2, #0
ADD R2, R3, R1 ;update head of stack
LD R7, R7_SAVE2
RET


UNDERFLOWDISP
ADD R3, R3, #1
LEA R0, UNDERFLOW1
PUTS
LD R7, R7_SAVE2
RET

;------
UNDERFLOW1 .STRINGZ "UNDERFLOW!\n"
STACK_BEGIN2 .FILL x3200
R7_SAVE2 .BLKW #1
;-------------------------------
;SUB_STACK_MULT 
;--------------------------------
.ORIG x4200
ST R7, R7_SAVE3
AND R6, R6, #0
AND R5, R5, #0
AND R4, R4, #0

LD R0, STACK_POP
JSRR R0
ADD R6, R0, #0 

LD R0, STACK_POP
JSRR R0
ADD R5, R0, #0
;single digit multiplication
MULTLOOP
ADD R4, R4, R5
ADD R6, R6, #-1
BRp MULTLOOP

AND R0, R0, #0
ADD R0, R4, #0 

;convert to ascii bc push subroutine converts from ascii
LD R4, NUM2A
ADD R0, R4, R0

LD R6, STACK_PUSH
JSRR R6
LD R7, R7_SAVE3
RET
;-----------------
R7_SAVE3 .BLKW #1
STACK_POP .FILL x4000
NUM2A .FILL #48
STACK_PUSH .FILL x3800
;----------------------------
;----------------------------

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to print the number to the user WITHOUT leading 0's and DOES NOT output the '+' 
;	for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4800
ST R0, R0_4800
ST R1, R1_4800
ST R2, R2_4800
ST R3, R3_4800
ST R5, R5_4800
ST R7, R7_4800
;R1, currently has input 1
;R2, currently has input 2
;R3, currently has product
;R4, currently has numer to "decode"
;R5, currently holds the current digit we are looking at
;R6, currently keeps track of how many negatives there are
LD R6, CHECKZER
LD R5, CHECKZER
ADD R5, R4, #0
BRp PRINTPOS;number is positive, print an +
Brn PRINTNEG;number is negative, print a - 
BRz PRINTSTART;number is 0, print nothing
PRINTPOS
	BRnzp PRINTSTART
PRINTNEG
	ADD R6, R6, #1
	LEA R0, NEGprint
	PUTS
	NOT R4, R4
	ADD R4, R4, #1

PRINTSTART
	LD R2, CHECKZER ;set r2 to 0	
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
			ADD R2, R2, #0
			BRp PRINTZERO1
				ADD R0, R1, #0
				BRz SKIP1
			PRINTZERO1
			LD R0, CHECKZER
			ADD R0, R1, #0
			ADD R2, R2, #1
			ADD R0, R0, R5 
		 	OUT							;print

SKIP1
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
			ADD R2, R2, #0
			BRp PRINTZERO2
				ADD R0, R1, #0
				BRz SKIP2
			PRINTZERO2
			LD R0, CHECKZER
			ADD R0, R1, #0
			ADD R2, R2, #1
			ADD R0, R0, R5 
		 	OUT							;print
	
	SKIP2	
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
			ADD R2, R2, #0
			BRp PRINTZERO3
				ADD R0, R1, #0
				BRz SKIP3
			PRINTZERO3
			LD R0, CHECKZER
			ADD R0, R1, #0
			ADD R2, R2, #1
			ADD R0, R0, R5 
		 	OUT							;print
	
	SKIP3	
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
			ADD R2, R2, #0
			BRp PRINTZERO4
				ADD R0, R1, #0
				BRz SKIP4
			PRINTZERO4
			LD R0, CHECKZER
			ADD R0, R1, #0
			ADD R2, R1, #0
			ADD R0, R0, R5 
		 	OUT							;print
	
	SKIP4	
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


LD R0, R0_4800
LD R1, R1_4800
LD R2, R2_4800
LD R3, R3_4800
LD R5, R5_4800
LD R7, R7_4800

RET

;--------------
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

R0_4800 .BLKW #1
R1_4800 .BLKW #1
R2_4800 .BLKW #1
R3_4800 .BLKW #1
R4_4800 .BLKW #1
R5_4800 .BLKW #1
R7_4800 .BLKW #1
