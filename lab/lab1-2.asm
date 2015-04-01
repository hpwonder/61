;===============
;Chuanping Fan
;cfan002@ucr.edu
;
;Lab01
;===============
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

