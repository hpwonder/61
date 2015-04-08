;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;04/08/2015
;
;Lab02
;Exercise 2
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LDI R3, DEC_65
	LDI R4, HEX_41
	
	ADD R3, R3, #1
	ADD R4, R4, #1

	STI R3, DEC_65
	STI R4, HEX_41

	HALT

;----------
;Local data 
;----------
DEC_65 .FILL x4000 ;these values should correspond to a capital "A"
HEX_41 .FILL x4001
	
;----------
;Next Data Block
;----------
.ORIG x4000

	NEW_DEC_65 .FILL #65
	NEW_HEX_41 .FILL x41

.END

