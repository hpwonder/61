;=================
;Chuanping Fan
;cfan002@ucr.edu
;Lab Section 026
;
;Assignment 1
;Created: 4/1/15
;=================
;
;**********************Table******************************************************
;REG VALUES	R0	 R1	 R2	 R3	 R4	 R5	 R6	 R7
;Pre-Loop	0  	 0   	 12	 6	 0	 0	 0	 1168
;1		0	 12	 12	 5	 0 	 0 	 0 	 1168
;2		0	 24	 12 	 4	 0	 0	 0	 1168
;3		0	 36      12      3       0       0       0       1168
;4		0 	 48      12      2       0       0       0       1168
;5		0	 60	 12      1       0       0 	 0 	 1168
;6		0	 72	 12	 0 	 0 	 0	 0	 1168
;End            0        72      12      0       0       0       0       Dec_0
;**********************Table******************************************************
;
.ORIG x3000
;------------
;Instructions
;------------
	LD R1, DEC_0
	LD R2, DEC_12
	LD R3, DEC_6

	DO_WHILE_LOOP
		ADD R1, R1, R2 ;pretty much r1=r1+r2
		ADD R3, R3, #-1 ;R3 is our iterator, subtracks r3 by 1
		BRp DO_WHILE_LOOP ; Works on the last executed thingy, so as long as r3 is positive (p)
	END_DO_WHILE_LOOP
	
	HALT
;----------
;Local data 
;----------
	DEC_0 .FILL #0
	DEC_12 .FILL #12
	DEC_6 .FILL #6

.END

