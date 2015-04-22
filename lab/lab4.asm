;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;04/22/2015
;
;Lab04
;Exercise 1
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LD R3, COUNT
	LD R4, NUMSTART
	LD R5, DATA_PTR
	FORLOOP
		STR R4, R5, #0
		ADD R5, R5, #1
		ADD R4, R4, #1

		ADD R3, R3, #-1
		BRp FORLOOP
	
	LD R5, DATA_PTR
	ADD R5, R5, #6
	LDR R2, R5, #0

	HALT

;----------
;Local data 
;----------
DATA_PTR .FILL x4000 ;Label called DATA_PTR that refers to the address x4000
COUNT .FILL #10
NUMSTART .FILL #0
;----------
;Next Data Block
;----------
.ORIG x4000
.BLKW #10

.END

