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
GETC
LD R6, SUB_STACKPUSH
JSRR R6
GETC
LD R6, SUB_STACKPUSH
JSRR R6
GETC
LD R6, SUB_STACKPUSH
JSRR R6
GETC
LD R6, SUB_STACKPUSH
JSRR R6

LD R6, SUB_STACKPOP
JSRR R6


HALT
;---------
STACK_ADDRESS .FILL x3200
SUB_STACKPUSH .FILL x3800
SUB_STACKPOP .FILL x4000
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

