
.syntax	unified
.cpu	cortex-m4
.text 

.global PutNibble
.thumb_func
.align
PutNibble: 	
//R0 = array of nibbles
//R1 = which (uint_32) -> A nibble position within the array of nibbles
//R2 = value (uint_32) -> A four-bit binary value (0000 to 1111)
	
	LSL R3, R1, 31
	LSR R3, R3, 31
	CMP R3, 0
	IT EQ
		BEQ Even
	B Odd

	Even: //lower half
		LSR R1, R1, 1
		LDRB R3, [R0,R1]
		//GET RID OF THE LAST 4 BITS 0-3
		LSR R3, R3, 4
		LSL R3, R3, 4
		ORR R3, R3, R2
		STRB R3, [R0,R1]
		BX LR

	Odd: //upper half
		LSR R1, R1, 1
		LDRB R3, [R0,R1]
		//GET RID OF BITS 3-7
		LSL R3, R3, 28
		LSR R3, R3, 28
		LSL R2, R2, 4
		ORR R3, R3, R2
		STRB R3, [R0,R1]
		BX LR



.global GetNibble
.thumb_func
.align
GetNibble: 	
//R0 = array of nibbles
//R1 = which (uint_32) -> A nibble position within the array of nibbles

	LSL R3, R1, 31
	LSR R3, R3, 31
	CMP R3, 0
	IT EQ
		BEQ Even2
	B Odd2

	Even2: //lower half
		LSR R1, R1, 1
		LDRB R3, [R0,R1]
		LSL R3, R3, 28
		LSR R3, R3, 28
		MOV R0, R3
		BX LR
		

	Odd2: //upper half
		LSR R1, R1, 1
		LDRB R3, [R0,R1]
		LSR R3, R3, 4
		MOV R0, R3
		BX LR