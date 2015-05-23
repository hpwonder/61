;=================================================
; 
; Name: <Fan, Chuanping>
; Username:
;
; SID: 861105608
; Assignment name: <assn 6>
; Lab section: 
; TA: 
;
; I hereby certify that I have not receieved 
; assistance on this assignment, or used code,
; from ANY outside source other than the
; instruction team. 
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
	LD R0, LOADMENU
	JSRR R0

	HALT
;---------------	
;Data
;---------------
	LOADMENU .FILL x3100
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3100
	MENUSTART
	LD R0, Menu_string_addr
	PUTS

	GETC
	OUT
	MENUOPTION
	;LD R5, ENTER ;check for enter
	;	ADD R5, R5, R0
	;	BRz	LOADSTASH
	LD R5, entered1 ;
		ADD R5, R5, R0
		BRz ALLBUSY
	LD R5, entered2 ;
		ADD R5, R5, R0
		BRz ALLFREE
	LD R5, entered3 ;
		ADD R5, R5, R0
		BRz NUMBUSY
	LD R5, entered4 ;
		ADD R5, R5, R0
		BRz NUMFREE
	LD R5, entered5 ;
		ADD R5, R5, R0
		BRz STATUS
	LD R5, entered6 ;
		ADD R5, R5, R0
		BRz FIRSTAVAIL
	LD R5, entered7 ;
		ADD R5, R5, R0
		BRz QUIT
	ERROR
		LEA R0, Error_message_1
		PUTS
	BR MENUSTART
	
	ALLBUSY
		LEA R0, newline1
		PUTS
		LD R0, CHECKALL
		JSRR R0	
		BR MENUSTART
	ALLFREE
		LEA R0, newline1
		PUTS	
		LD R0, CHECKALLFREE
		JSRR R0
		BR MENUSTART
	NUMBUSY
		LEA R0, newline1
		PUTS
		LD R0, CHECKBUSY
		JSRR R0
		BR MENUSTART
	NUMFREE
		LEA R0, newline1
		PUTS
		LD R0, CHECKNUMFREE
		JSRR R0
		BR MENUSTART
	STATUS
		LEA R0, newline1
		PUTS	
		LD R0, CHECKSPECIFIC
		JSRR R0	
		BR MENUSTART
	FIRSTAVAIL
		LEA R0, newline1
		PUTS
		LD R0, CHECKAVAIL
		JSRR R0	
		BR MENUSTART	

	QUIT
		LEA R0, newline1
		PUTS
		LEA R0, Exit_str
		PUTS
	RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "INVALID INPUT\n"
Menu_string_addr .FILL x6000
Exit_str .STRINGZ "Goodbye!\n"
entered1 .FILL #-49
entered2 .FILL #-50
entered3 .FILL #-51
entered4 .FILL #-52
entered5 .FILL #-53
entered6 .FILL #-54
entered7 .FILL #-55
newline1 .STRINGZ "\n"

CHECKALL .FILL x3200
CHECKALLFREE .FILL x3300
CHECKBUSY .FILL x2350
CHECKNUMFREE .FILL x3500
CHECKSPECIFIC .FILL x4600
CHECKAVAIL .FILL x2700
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x3200
	ST R7, R7HOLDER2
	
	LD R1, VECTOR2
	LDR R1, R1, #0
	BRz YESFREE
		LEA R0, NOTFREE
		PUTS
		LD R7, R7HOLDER2
		RET
	
	YESFREE
		LEA R0, FREE
		PUTS
		LD R7, R7HOLDER2
		RET

VECTOR2 .FILL x5000
NOTFREE .STRINGZ "Not all machines are busy\n"
FREE .STRINGZ "All machines are busy\n"
R7HOLDER2 .BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3300

	ST R7, R7HOLDER
	LD R6, VECTOR1
	LDR R6, R6, #0
	LD R5, CHECKALLCOUNTER1
	AND R4, R4, #0

	ADD R6, R6, #0
	BRn ADDONE ;negative means msb is 1, so 1
	BRzp SUBONE ;positive means msb is 0, so 0
	
	CHECKALLLOOP1
		ADD R6, R6, R6
		BRn ADDONE ;negative means msb is 1, so 1
		BRzp SUBONE ;positive means msb is 0, so 0
	BRp CHECKALLLOOP1
	
	DISPLAY
		ADD R4, R4, #-16 ;if machine is busy then all 0's
		ADD R4, R4, #0
		BRz ALLFREESEC 
			LEA R0, NOTFREE1
			PUTS
			LD R7, R7HOLDER
			RET
		ALLFREESEC
			LEA R0, ALLMACHINESFREE
			PUTS
			LD R7, R7HOLDER
			RET
	
	ADDONE
		ADD R4, R4, #1
		ADD R5, R5, #-1
		BRp CHECKALLLOOP1
		BRnz DISPLAY

	SUBONE
		ADD R5, R5, #-1
		BRp CHECKALLLOOP1
		BRnz DISPLAY

ascii1 .FILL #-48
CHECKALLCOUNTER1 .FILL #16
VECTOR1 .FILL x5000
NOTFREE1 .STRINGZ "Not all machines are free\n"
ALLMACHINESFREE .STRINGZ "All machines are free\n"
R7HOLDER .BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.ORIG x2350
	ST R7, R7HOLDER3
	LD R6, VECTOR3
	LDR R6, R6, #0
	LD R5, CHECKBUSYCOUNTER
	AND R4, R4, #0

	ADD R6, R6, #0
	BRzp ADDONE2 ;negative means msb is 1, so 1
	BRn SUBONE2 ;positive means msb is 0, so 0

	CHECKBUSYLOOP
		ADD R6, R6, R6
		BRzp ADDONE2 ;negative means msb is 1, so 1
		BRn SUBONE2 ;positive means msb is 0, so 0
	
	BRp CHECKBUSYLOOP
	
	DISPLAY2
		LEA R0, FIRSTSTR1
		PUTS
		
		LD R0, PRINTNUM1
		JSRR R0

		LEA R0, SECONDSTR1
		PUTS

		LD R7, R7HOLDER3
		RET
	
	ADDONE2
		ADD R4, R4, #1
		ADD R5, R5, #-1
		BRp CHECKBUSYLOOP
		BRnz DISPLAY2

	SUBONE2
		;ADD R4, R4, #-1
		ADD R5, R5, #-1
		BRp CHECKBUSYLOOP
		BRnz DISPLAY2

ascii3 .FILL #48
PRINTNUM1 .FILL x3800
CHECKBUSYCOUNTER .FILL #16
VECTOR3 .FILL x5000
R7HOLDER3 .BLKW #1
FIRSTSTR1 .STRINGZ "There are "
SECONDSTR1 .STRINGZ " machines busy\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.ORIG x3500
	ST R7, R7HOLDER4
	LD R6, VECTOR4
	LDR R6, R6, #0
	LD R5, CHECKFREECOUNTER
	AND R4, R4, #0

	ADD R6, R6, #0
	BRzp ADDONE3 ;negative means msb is 1, so 1
	BRn SUBONE3 ;positive means msb is 0, so 0

	CHECKFREELOOP
		ADD R6, R6, R6
		BRzp ADDONE3 ;negative means msb is 1, so 1
		BRn SUBONE3 ;positive means msb is 0, so 0
	
	BRp CHECKFREELOOP
	
	DISPLAY3
		LEA R0, FIRSTSTR2
		PUTS
		LD R3, CHECKFREECOUNTER
		NOT R4, R4
		ADD R4, R4, #1
		ADD R4, R4, R3

		LD R0, PRINTNUM2
		JSRR R0

		LEA R0, SECONDSTR2
		PUTS
		LD R7, R7HOLDER4
		RET
	
	ADDONE3
		ADD R4, R4, #1
		ADD R5, R5, #-1
		BRp CHECKFREELOOP
		BRnz DISPLAY3

	SUBONE3
		;ADD R4, R4, #-1
		ADD R5, R5, #-1
		BRp CHECKFREELOOP
		BRnz DISPLAY3

PRINTNUM2 .FILL x3800
CHECKFREECOUNTER .FILL #16
VECTOR4 .FILL x5000
R7HOLDER4 .BLKW #1
FIRSTSTR2 .STRINGZ "There are "
SECONDSTR2 .STRINGZ " machines free\n"
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.ORIG x4600
	ST R7, SAVR7
	LD R0, ASKNUM
	JSRR R0

	AND R4, R4, #0
	ADD R4, R1, #0
	LEA R0, MACHINESTR
	PUTS
	LD R0, READSTRING
 	JSRR R0
	
	LD R2, NUMMACHINES
	NOT R6, R1
	ADD R6, R6, #1
	ADD R6, R6, R2
	BRz SPECIALCASE

	LD R5, TIME4BUSYNESS
	LDR R5, R5, #0
	ISAVAILLOOP
		ADD R5, R5, R5
		ADD R6, R6, #-1
	BRp ISAVAILLOOP
	
	ADD R5, R5, #0
	BRzp ITISAZERO
		LEA R0, ISFREEstr
		PUTS
		LD R7, SAVR7
		RET
	
	ITISAZERO
		LEA R0, ISBUSYstr
		PUTS
		LD R7, SAVR7
		RET
	
	SPECIALCASE
		AND R5, R5, R2
		BRn SPECIALCASEFREE
			LEA R0, ISFREEstr
			PUTS
			LD R7, SAVR7
			RET
		SPECIALCASEFREE	
			LEA R0, ISFREEstr
			PUTS
			LD R7, SAVR7
			RET
;----------DATA------------
TIME4BUSYNESS .FILL x5000
NUMMACHINES .FILL #15	
ASKNUM .FILL x4100
MACHINESTR .STRINGZ "Machine "
ISBUSYstr .STRINGZ " is busy\n"
ISFREEstr .STRINGZ " is free\n"
READSTRING .FILL x3800
SAVR7 .BLKW #1
SPECIALTEST .FILL x8000
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.ORIG x2700
	ST R7, R7HOLDER5
	LD R6, VECTOR5
	LDR R6, R6, #0
	LD R5, NUMBEROFMACHINES
	AND R4, R4, #0

	ADD R6, R6, #0
	BRzp ADDONE4 ;negative means msb is 1, so 1
	BRn SUBONE4 ;positive means msb is 0, so 0

	FIRSTAVAILLOOP
		ADD R6, R6, R6
		BRzp ADDONE4 ;negative means msb is 1, so 1
		BRn SUBONE4 ;positive means msb is 0, so 0
	BRp FIRSTAVAILLOOP
	
	DISPLAY4
		LEA R0, FIRSTSTRING3
		PUTS

		LD R0, PRINTNUM3
		JSRR R0

		LEA R0, NEWLINEULTRA
		PUTS
		LD R7, R7HOLDER5
		RET
	
	ADDONE4 ;notavailable
		ADD R5, R5, #-1
		BRp FIRSTAVAILLOOP
		BRnz DISPLAY4

	SUBONE4 ;available
		AND R4, R4, #0
		ADD R4, R4, R5
		ADD R4, R4, #-1

		ADD R5, R5, #-1
		BRp FIRSTAVAILLOOP
		BRnz DISPLAY4

FIRSTSTRING3 .STRINGZ "The first available machine is number "
NEWLINEULTRA .STRINGZ "\n"
PRINTNUM3 .FILL x3800
NUMBEROFMACHINES .FILL #16
VECTOR5 .FILL x5000
R7HOLDER5 .BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4100
BEGIN_GET_INPUT
ST R0, R0_4100
ST R2, R2_4100
ST R3, R3_4100
ST R4, R4_4100
ST R5, R5_4100
ST R6, R6_4100
ST R7, R7_4100

GET_INPUT_START

LD R1, ZERO ;Initialize final register to 0
LD R2, ZERO ; used as a temp
LD R3, arraybegin ; outer counter
LD R4, ZERO ; inner counter
LD R5, TEN  ; counter for multiplying by 10
LD R6, ZERO ; NEGATIVE FLAG
LEA R0, prompt  ; Output Intro Message
PUTS

	BEGIN
	GETC
	OUT

	LD R5, NEGATIVE ; Check if -
	ADD R5, R5, R0
	BRz negINPUT
								
	LD R5, POSITIVE ;Check if +
	ADD R5, R5, R0
		BRz FIRSTSKIP
	LD R5, ENTER ;check for enter
	ADD R5, R5, R0
		BRz INVALID1
																		
	NUMBERSONLY
		LD R5, ENTER ;check for enter
		ADD R5, R5, R0
		BRz	LOADSTASH
	LD R5, negASCII ;check for non-numerical
		ADD R5, R5, R0
		BRn INVALID1
	LD R5, posASCII ;^ (after 57 ascii)
		ADD R5, R5, R0
		BRp INVALID1
																																											
	ADDDEC ;take number, convert into decimal and store into array
		LD R5, negASCII
		ADD R0, R0, R5 ;convert input from ascii char into dec
		STR R0, R3, #0 ;store digit into array
		ADD R3, R3, #1 ;Increment array
		ADD R4, R4, #1 ;increment number of elements in array (decimal places)
	ENDDEC		
	
	FIRSTSKIP ;jump here if + or - is detected, otherwise would have been checked twice
	GETC
	OUT
	BR NUMBERSONLY	
	
LOADSTASH
LD R3, arraybegin ;set array back to beginning
	OUTERLOOP
		LD R5, ZERO ; reset
		LDR R0, R3, #0 ;put current value of array into R3
		ADD R5, R0, #0 ; Copy it into R5
		ADD R2, R4, #0 ;copy r4 into r2
		ADD R2, R2, #-1 ;subtract 1 from 10^
		BRz ONESDIGIT
		RELOAD ;multiply by another set of 10
		INNERLOOP	;multiply by 10
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			ADD R0, R0, R5
			LD R5, ZERO
			ADD R5, R0, #0 ;next digit
			ADD R2, R2, #-1
			BRp RELOAD
		ONESDIGIT
			ADD R1, R1, R0
			ADD R3, R3, #1 ;increment array
			ADD R4, R4, #-1 ;decrease elements left in array
			BRp OUTERLOOP

ADD R6, R6, #0
	BRp NEGFLAG
	BR ENDPROG

	INVALID1
		;LEA R0, NEWLINE
		;PUTS
		LEA R0, Error_message_2
		PUTS
		BR GET_INPUT_START
	negINPUT ;negative detected, waiting for first number
		ADD R6, R6, #1
		BR FIRSTSKIP 
	NEGFLAG
		NOT R1, R1
		ADD R1, R1, #1
	
ENDPROG

ADD R1, R1, #0
BRn INVALID1
LD R2, negfifteen
ADD R2, R2, R1
BRp INVALID1

LD R0, R0_4100
LD R2, R2_4100
LD R3, R3_4100
LD R4, R4_4100
LD R5, R5_4100
LD R6, R6_4100
LD R7, R7_4100

RET

R0_4100 .BLKW #1
R2_4100 .BLKW #1
R3_4100 .BLKW #1
R4_4100 .BLKW #1
R5_4100 .BLKW #1
R6_4100 .BLKW #1
R7_4100 .BLKW #1

negfifteen .FILL #-15
arraybegin .FILL x4000
ZERO .FILL #0
NEGATIVE .FILL #-45
POSITIVE .FILL #-43
NEWLINE .STRINGZ "\n"
CHECKNUM .FILL #9
negASCII .FILL #-48
posASCII .FILL #-58
ENTER .FILL #-10
TEN .FILL #10
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to print the number to the user WITHOUT leading 0's and DOES NOT output the '+' 
;	for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x3800
ST R0, R0_3800
ST R1, R1_3800
ST R2, R2_3800
ST R3, R3_3800
ST R5, R5_3800
ST R7, R7_3800
;R1, currently has input 1
;R2, currently has input 2
;R3, currently has product
;R4, currently has numer to "decode"
;R5, currently holds the current digit we are looking at
;R6, currently keeps track of how many negatives there are
LD R6, CHECKZER
LD R5, CHECKZER
ADD R5, R4, #0
BRp PRINTPOS;number is positive, print an +
Brn PRINTNEG;number is negative, print a - 
BRz PRINTSTART;number is 0, print nothing
PRINTPOS
	BRnzp PRINTSTART
PRINTNEG
	ADD R6, R6, #1
	LEA R0, NEGprint
	PUTS
	NOT R4, R4
	ADD R4, R4, #1

PRINTSTART
	LD R2, CHECKZER ;set r2 to 0	
	LD R1, CHECKZER ;set r1 to 0
	TENTHOUS
		LD R5, NEGTENT ;set r5 to -10000
		ADD R4, R4, R5 ;subtract num from 10000
		BRn UNDOTENT ;if it goes into negatives, undo it
			ADD R1, R1, #1 ;else add 1 to digit counter
			BRnzp TENTHOUS
		UNDOTENT
			LD R5, POSTENT ;add 10000 back in
			ADD R4, R4, R5
			BRnzp PRINTTENTHOUS
		PRINTTENTHOUS
			LD R0, CHECKZER ;set r1 to 0
			LD R5, PRINTCONVERT; load ascii conversion into r5
			ADD R2, R2, #0
			BRp PRINTZERO1
				ADD R0, R1, #0
				BRz SKIP1
			PRINTZERO1
			LD R0, CHECKZER
			ADD R0, R1, #0
			ADD R2, R2, #1
			ADD R0, R0, R5 
		 	OUT							;print

SKIP1
	LD R1, CHECKZER
	THOUS
		LD R5, NEGT
		ADD R4, R4, R5
		BRn UNDOT
			ADD R1, R1, #1 ;else add 1 to digit
			BRnzp THOUS
		UNDOT
			LD R5, POST
			ADD R4, R4, R5
			BRnzp PRINTTHOUS
		PRINTTHOUS
			LD R0, CHECKZER
			LD R5, PRINTCONVERT
			ADD R2, R2, #0
			BRp PRINTZERO2
				ADD R0, R1, #0
				BRz SKIP2
			PRINTZERO2
			LD R0, CHECKZER
			ADD R0, R1, #0
			ADD R2, R2, #1
			ADD R0, R0, R5 
		 	OUT							;print
	
	SKIP2	
	LD R1, CHECKZER
	HUNDRED
		LD R5, NEGHUNDRED ;load -100
		ADD R4, R4, R5 ;subtract 100 from total
		BRn UNDOHUNDRED
			ADD R1, R1, #1 ;else add 1 to digit
			BRnzp HUNDRED ;go back and do it again if not negative
		UNDOHUNDRED
			LD R5, POSHUNDRED ;went into negatives, lets add it back in
			ADD R4, R4, R5
			BRnzp PRINTHUNDRED
		PRINTHUNDRED
			LD R0, CHECKZER
			LD R5, PRINTCONVERT
			ADD R2, R2, #0
			BRp PRINTZERO3
				ADD R0, R1, #0
				BRz SKIP3
			PRINTZERO3
			LD R0, CHECKZER
			ADD R0, R1, #0
			ADD R2, R2, #1
			ADD R0, R0, R5 
		 	OUT							;print
	
	SKIP3	
	LD R1, CHECKZER
	TENS
		LD R5, NEGTEN ;load -10
		ADD R4, R4, R5
		BRn UNDOH
			ADD R1, R1, #1 ;else add 1 to digit
			BRnzp TENS 
		UNDOH
			LD R5, POSTEN ;load +10
			ADD R4, R4, R5
			BRnzp PRINTTEN
		PRINTTEN
			LD R0, CHECKZER
			LD R5, PRINTCONVERT
			ADD R2, R2, #0
			BRp PRINTZERO4
				ADD R0, R1, #0
				BRz SKIP4
			PRINTZERO4
			LD R0, CHECKZER
			ADD R0, R1, #0
			ADD R2, R1, #0
			ADD R0, R0, R5 
		 	OUT							;print
	
	SKIP4	
	LD R1, CHECKZER
	ONES
		LD R5, NEGUNO
		ADD R4, R4, R5
		BRn UNDOUNO
			ADD R1, R1, #1 ;else add 1 to digit
			BRnzp ONES
		UNDOUNO
			LD R5, POSUNO
			ADD R4, R4, R5
			BRnzp PRINTUNO
		PRINTUNO
			LD R0, CHECKZER
			LD R5, PRINTCONVERT
			ADD R0, R1, #0
			ADD R0, R0, R5 ;convert from ascii to dec
		 	OUT


LD R0, R0_3800
LD R1, R1_3800
LD R2, R2_3800
LD R3, R3_3800
LD R5, R5_3800
LD R7, R7_3800

RET

;--------------------------------
;Data for subroutine print number
;--------------------------------
;--------------
;Data for subroutine:
;--------------
CHECKZER .FILL #0
POSTENT .FILL #10000
NEGTENT .FILL #-10000
POST .FILL #1000
NEGT .FILL #-1000
POSHUNDRED .FILL #100
NEGHUNDRED .FILL #-100
POSTEN .FILL #10
NEGTEN .FILL #-10
POSUNO .FILL #1
NEGUNO .FILL #-1
PRINTCONVERT .FILL #48

NEGprint .STRINGZ "-"
POSprint .STRINGZ "+"
NEWLINEprint .STRINGZ "\n"

R0_3800 .BLKW #1
R1_3800 .BLKW #1
R2_3800 .BLKW #1
R3_3800 .BLKW #1
R4_3800 .BLKW #1
R5_3800 .BLKW #1
R7_3800 .BLKW #1

;------------------------------------------------------------------
.ORIG x5000			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!
.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"
;---------------	
;END of PROGRAM
;---------------	
.END
