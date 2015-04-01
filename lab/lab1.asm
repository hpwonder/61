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
	LEA R0, MSG_TO_PRINT;
	PUTS;

	HALT;

;----------
;Local data 
;----------

	MSG_TO_PRINT .STRINGZ "HELLO WORLD!\n";

.END

