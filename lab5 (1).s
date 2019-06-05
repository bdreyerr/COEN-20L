
.syntax	unified
.cpu	cortex-m4
.text 

.global MyProduct
.thumb_func
.align
MyProduct: 	
	CMP R0, 0
	BNE Label1
	BX LR
	Label1:
		PUSH {LR}
		SUB R0, R0, 1
		BL MyProduct
		ADD R0, R0, R1
		POP {PC}
		
		

	


.global MyFibonacci
.thumb_func
.align
MyFibonacci: 
	CMP R0, 1
	BHI Label2
	BX LR
	Label2:
		PUSH {R4-R5,LR}
		SUB R0, R0, 1
		MOV R4, R0
		BL MyFibonacci
		MOV R5, R0
		SUB R0, R4, 1
		BL MyFibonacci
		ADD R0, R0, R5
		POP {R4-R5,PC}

		
	


.global MyAckermann
.thumb_func
.align
MyAckermann: 
	
	CMP R0, 0
	ITT EQ
		ADDEQ R0, R1, 1
		BXEQ LR
	CMP R1, 0
	ITTT EQ
		SUBEQ R0, R0, 1
		MOVEQ R1, #1
		BEQ MyAckermann
	PUSH {R4, LR}
	SUB R1, R1, 1
	MOV R4, R0
	BL MyAckermann
	MOV R1, R0
	MOV R0, R4
	SUB R0, R0, 1
	BL MyAckermann
	POP {R4,PC}


	.end