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
	GETC
	OUT	

	LEA R1, MY_STRING
	MYLOOP
		LDR R0, R1, #0
		LDR R0, R0, #0
		BRz OUTLOOP

		ADD R1, R1, #1
	BR MYLOOP
	
	OUTLOOP
	HALT
;----------
;Local data 
;----------
	MY_STRING .STRINGZ "Sample String"
.END

