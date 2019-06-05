//Ben Dreyer
//COEN 20
//LAB 1: Binary Number Systems

#include <math.h>

void TwosComplement(const int input[8], int output[8]){ //Flip the sign of an 8bit Binary number 
	int i;
	int flag = 0;
	for (i = 0; i < 8; i++) { //loop through the binary value
		if (input[i] == 1 && flag == 0) { //If a 1 is found, and the flag hasnt been enabled
			output[i] = input[i]; //the 1 stays the same
			flag = 1; //enable flag
			continue; //go to the for loop iteration
		}
		if (flag == 1) { //if flag has been enabled, flip all remaining bits
			if (input[i] == 0)
				output[i] = 1;
			if (input[i] == 1)
				output[i] = 0;
		}
		else if(flag == 0){ //if flag hasnt been enabled, transfer the same value 
			output[i] = input[i];
		}
	}
}

float Bin2Dec(const int input[8]) {
	int i;
	float polynomial = 0 - input[7];
	
	for (i = 6; i >= 0; i--) {
		polynomial = 2 * polynomial + input[i];
	}
	
	return polynomial/128;
}

void Dec2Bin(float x, int input[8]) {
	int isNeg = 0;
	x *= 128;
	if (x < 0) {
		isNeg = 1;
		x = x * -1;
	}
	int y = x + 0.5;
	for (int i = 0; i < 8; i++) {
		input[i] = y % 2;
		y /= 2;
	}
	if (isNeg == 1) {
		int output[8];
		for (int i = 0; i < 8; i++) {
			output[i] = input[i];
		}
		TwosComplement(output,input);
	}
}

