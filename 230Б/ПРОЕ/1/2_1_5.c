#include <stdio.h>
#include <limits.h>
#include <math.h>

int main(int argc, char **argv)
{
	unsigned char array[8];
	int i, number = 0, j;
	
	for (i = 7; i >= 0; i--)
	{
		scanf("%c", &array[i]);
		j = (array[i] >= '0') * (array[i] <= '9') * powf(2,i);
		
// i =        7,        6,        5,        4,        3,        2,        1,        0
// ^ =      2^7,      2^6,      2^5,      2^4,      2^3,      2^2,      2^1,      2^0
//10 =      128,       64,       32,       16,        8,        4,        2,        1
// 2 = 10000000, 01000000, 00100000, 00010000, 00001000, 00000100, 00000010, 00000001
		
		// F19w0-65 ввод
		// 01101011 = 107
		
		printf("%d %c\n",j,array[i]);
		
		number += j;
	}
	
	printf("%d\n",number);
}
