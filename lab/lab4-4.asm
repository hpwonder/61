;=================================================
; 
; Name: Chuanping Fan
; Username: cfan002
;
; SID: 861105608
; Assignment name: assn 3
; Lab section: 029
; TA: Jose
;
; I hereby certify that I have not received 
; assistance on this assignment, or used code,
; from ANY outside source other than the
; instruction team. 
;
;=================================================

                .ORIG x3000			    ; Program begins here
               	LD R5, NUMELEMENTS ;10 elements
								LD R6, Convert_addr ;array address
								LD R4, FIRSTVAL	;start at 1
								CREATEARRAY
									STR R4, R6, #0
									ADD R4, R4, R4	; power of 2
									ADD R6, R6, #1	; increment array

									ADD R5, R5, #-1 ;decrement countre
								BRp CREATEARRAY

								LD R6, Convert_addr
								LD R5, NUMELEMENTS

								PRINTARRAY
								;-------------
                ;Instructions
                ;-------------
                LDR R1, R6, #0			; R1 <-- VARIABLE Convert 
								;-------------------------------
                ;INSERT CODE STARTING FROM HERE
                ;--------------------------------
								LD R3, sCOUNTER

								OUTERLOOP
								LD R2, bCOUNTER			;Inside outerloop because counter needs to be reset

								MAINLOOP
								ADD R1, R1, #0 			;enable Br comparison
								BRzp POS 						;Positive number
								BRn NEG

								POS
									LEA	R0, OUT0
									PUTS
									BRzp AFTERLOOP

								NEG
									LEA R0, OUT1
									PUTS

								AFTERLOOP
								
								ADD R1, R1, R1		;Left shift by doubling value in R1
								ADD R2, R2, #-1		;Reduce counter by 1
                
								BRp MAINLOOP			;
								BRz ADDSPACE			;

								ADDSPACE
								ADD R3, R3, #0
								BRz END
								LEA R0, SPACE
								PUTS
								
								ADD R3, R3, #-1
								BRzp OUTERLOOP
																	;Last 4 bits

								END
								LEA R0, NEWLINE
								PUTS

								ADD R6, R6, #1
								ADD R5, R5, #-1

								BRp PRINTARRAY

								HALT
                ;---------------	
                ;Data
                ;---------------
Convert_addr    .FILL x5000	            ; The address of where to find the data
bCOUNTER 				.FILL 4						;4 bits, then space
sCOUNTER 				.FILL 3						  ;for spaces (end must be terminated with newline)
OUT0						.STRINGZ "0"
OUT1						.STRINGZ "1"
SPACE						.STRINGZ " "
NEWLINE					.STRINGZ "\n"
NUMELEMENTS     .FILL #10
FIRSTVAL				.FILL #1

                .ORIG x5000			    ; Remote data
                .BLKW #10
								;---------------	
                ;END of PROGRAM
                ;---------------	
                .END
