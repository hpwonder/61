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
	LD R6, OFFSET

	FORLOOP
		STR R4, R5, #0 ;Store value at R4 into Address at R5
		ADD R5, R5, #1 ;Increment Array
		ADD R4, R4, R4 ;Next power of 2

		ADD R3, R3, #-1
		BRp FORLOOP
	
	LD R5, DATA_PTR ;start at x4000 again
	ADD R5, R5, #7 ;jump to 7th element
	LDR R2, R5, #0 ;Load value at the address of R5 into R2
	
	HALT

;----------
;Local data 
;----------
DATA_PTR .FILL x4000 ;Label called DATA_PTR that refers to the address x4000
COUNT .FILL #10
NUMSTART .FILL #1
OFFSET .FILL #48
;----------
;Next Data Block
;----------
.ORIG x4000
.BLKW #10

.END

