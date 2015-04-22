;=========================================================
;Chuanping Fan
;cfan002@ucr.edu
;04/22/2015
;
;Lab04
;Exercise 2
;=========================================================
.ORIG x3000
;------------
;Instructions
;------------
	LD R3, COUNT
	LD R4, NUMSTART
	LD R5, DATA_PTR
	LD R1, OFFSET
	
	FORLOOP
		STR R4, R5, #0
		ADD R5, R5, #1
		ADD R4, R4, #1

		ADD R3, R3, #-1
		BRp FORLOOP
	
	LD R5, DATA_PTR
	LD R3, COUNT

	DISPLAY
		ADD R0, R1, R5
		OUT

		ADD R5, R5, #1
		
		ADD R3, R3, #-1
	BRp DISPLAY

	HALT

;----------
;Local data 
;----------
DATA_PTR .FILL x4000 ;Label called DATA_PTR that refers to the address x4000
COUNT .FILL #10
NUMSTART .FILL #0
OFFSET .FILL #48
;----------
;Next Data Block
;----------
.ORIG x4000
.BLKW #10

.END

