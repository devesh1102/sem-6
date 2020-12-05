;****************************************************************
; IIR FILTER ASSEMBLY IMPLEMENTATION

      .ARMS_off                     ;enable assembler for ARMS=0
      .CPL_on                      	;enable assembler for CPL=1
      .mmregs                       ;enable mem mapped register names

	.global _directform1			; Direct form 1 Function Name
	.global _inPtr					; Pointer containing the Address of Input
	.global _outPtr					; Pointer containing the Address of Output
	.global _numCoeff			    ;  Pointer containing the First Address of Numerator Coefficient Array;
	.global _denCoeff			    ;  Pointer containing the First Address of Denominator Coefficient Array;


	.data							;data section
									;section where all the data is stored 

inp_len	.set 3  					; length of the input buffer  ex: number of coefficients in the numerator array = 3

	.align 16	
			
inpbuff	.space 16*inp_len			; allocating buffer space 
									; Each input of input buffer
									; is represented in 16 Bits
									; 16 times the numerator coefficient array length.
									
out_len	.set 2  					; length of the Output buffer  ex: number of coefficients in the denominator array = 3-1

	.align 16
				
outbuff	.space 16*out_len			; allocating buffer space 
									; Each output in output buffer
									; is represented in 16 Bits
									; 16 times the denominator coefficient array length - 1.									
									

oldindex_in	.word  0				; Allocate storage to save oldindex of the input buffer
									; (defines where next sample has to be put in input buffer)

oldindex_out	.word  0				; Allocate storage to save oldindex of the output buffer
									; (defines where next sample has to be put in output buffer)
									
									

	.text							;this section contains the code 

_directform1							; Direct Form 1 function definition

; section 1: loading address
	
	MOV		dbl(*(#_inPtr)),    XAR6		    ; XAR6 contains address to input;
    MOV		dbl(*(#_numCoeff)), XAR2		; XAR2 contains address to First Address of Numerator Coefficient Array;
    MOV     dbl(*(#_denCoeff)), XAR5		; XAR5 contains address to First Address of Denominator Coefficient Array;
    MOV		dbl(*(#_outPtr)),   XAR7		    ; XAR7 contains address to Output;


;*************************************************************
;***** Your circular buffer configuration code goes here *****
;*************************************************************



 	MOV *(#oldindex_in),AR1				; Initialing the AR1 to Oldindex of input buffer
 	
 
 	
 	MOV *(#oldindex_out),AR4        	; Initialing the AR4 to Oldindex of input buffer
 
 

	MOV *AR6, *AR1+;			; Receive input and store it in the location pointed by *AR1  ; i.e, location BSA01 + AR1
    
  
;*********************************************
;***** Your IIR code goes here , Use AC0 for accumulation *******
;*********************************************




	; Divide AC0 with a0 ( i.e 100 )
	
	MOV AC0,AR3 ;
	SFTL AC0, #-5
	ADD AR3,AC0
	SFTL AC0, #2
	ADD AR3  ,AC0
	SFTL AC0, #-9
	
	
	

	
	
	
										
	MOV AC0,*AR7					; Move the result to the output pointer, here AR7 is containing the output address						

;*********************************************
    RET
