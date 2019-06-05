.syntax	unified
.cpu	cortex-m4
.text 

.global  GetBit
.thumb_func
.align
GetBit:
.if 0

	//returns either 0 or 1, corresponding to a bit of the coded message located at position bitnum (starting at position 0)
	//R0 = &msg
	//R1 = bitnum 
	
	AND		R2, R1, 0x000000007 	//extrac the first 3 bits from bitnum
	LSR		R1, R1, 3				//divide by 8
	LDRB	R0, [R0,R1]
	LSR		R0, R0, R2
	AND 	R0, R0, 0x000000001
	
	BX LR

		
.else

	SUB 	R0, R0, 0x20000000
	LSL 	R0, R0, 5
	ADD 	R0, R0, R1, LSL 2
	ADD 	R0, R0, 0x22000000
	LDR 	R0, [R0]
	BX 		LR
	
	

.endif


.global  DecodeMessage
.thumb_func
.align
DecodeMessage:

	//R0 = &msg
	//R1 = &array
	
	PUSH 	{R4-R8, LR}
	MOV		R5, R0		//Copy R0 into R5	
	MOV 	R6, R1		//Copy R1 into R6
	LDR 	R7, =0		//counter for Getbit = 0
start:
	LDR 	R8, =0		//R2 = K = 0
top:
	MOV		R0, R5
	MOV 	R1, R7
	BL		GetBit		//Getbit returns bit in R0
	LSL 	R8, R8, 1	//k = k * 2
	ADD		R0, R0, 1	//bit = bit + 1
	ADD		R8, R8, R0	//K = K*2 + 1 + bit
	LDRB	R0, [R6, R8]//byte = array[k]
	ADD  	R7, R7, 1	//increment counter for get bit
	CMP 	R0, 0
	BEQ 	top
	CMP 	R0, '$'
	BEQ		return
	BL 		putchar
	
	B		start
	
return:
	POP 	{R4-R6, LR}
	BX 		LR
	
	
	