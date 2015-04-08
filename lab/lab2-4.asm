;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;04/08/2015
;
;Lab02
;Exercise 4
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LD R0, HEX_61
	LD R1, HEX_1A
	
	THE_WHILE_LOOP
		OUT
		ADD R0, R0, #1
		ADD R1, R1, #-1
		BRp THE_WHILE_LOOP
	END_OF_LOOP
	HALT


;----------
;Local data 
;----------
	HEX_61 .FILL x61
	HEX_1A .FILL x1A
.END

