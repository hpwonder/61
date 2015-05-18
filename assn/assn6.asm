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


HALT
;---------------	
;Data
;---------------

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

;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "INVALID INPUT\n"
Menu_string_addr .FILL x6000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------

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

;--------------------------------
;Data for subroutine print number
;--------------------------------



.ORIG x5000			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!
.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"
;---------------	
;END of PROGRAM
;---------------	
.END
