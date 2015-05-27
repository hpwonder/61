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


HALT
STACK_ADDRESS .FILL x3200
SUB_STACKPUSH .FILL x3800

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
GETC ;input to r0
ADD R3, R3, #1;increment counter
ADD R6, R3, #-9
BRz OVERFLOWDISP

ADD R2, R3, R1;add counter to array. this is the top element 
STR R0, R2, #0

LD R7, R7_SAVE1
RET

OVERFLOWDISP
LEA R0, OVERFLOW1
LD R7, R7_SAVE1
RET

STACK_BEGIN .FILL x3800
R7_SAVE1 .BLKW #1
OVERFLOW1 .STRINGZ "OVERFLOW!\n"
