;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;04/08/2015
;
;Lab02
;Exercise 1
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LD R3, DEC_65
	LD R4, HEX_41

	HALT
;----------
;Local data 
;----------
	DEC_65 .FILL #65 ;these values should correspond to a capital "A"
	HEX_41 .FILL x41
	DEC_6 .FILL #6

.END

