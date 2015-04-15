;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;04/15/2015
;
;Lab03
;Exercise 1
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LD R5, DATA_PTR

	LDR R3, R5, #0 ;Load memory  location x4000 into R3
	ADD R3, R3, #1

	STR R3, R5, #0
	ADD R5, R5, #1

	STR R3, R5, #0
	HALT

;----------
;Local data 
;----------
DATA_PTR .FILL x4000 ;Label called DATA_PTR that refers to the address x4000
;----------
;Next Data Block
;----------
.ORIG x4000

	NEW_DEC_65 .FILL #65
	NEW_HEX_41 .FILL x41

.END

