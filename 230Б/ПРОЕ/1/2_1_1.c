#include <stdio.h>
#include <limits.h>

int main(int argc, char **argv)
{
	unsigned char x;
	
	scanf("%hhu",&x);
	
	signed char y;
	
	scanf("%hhd",&y);
	
	unsigned char x1 = x;
	signed char y1 = y;
	
	int xMax = 0, xMin = 0, yMax = 0, yMin = 0;
	
	unsigned char maxUChar = x, minUChar = x;
	signed char maxSChar = y, minSChar = y;
	
	unsigned char maxUCharOld = maxUChar, minUCharOld = minUChar;
	signed char maxSCharOld = maxSChar, minSCharOld = minSChar;
	
	printf("\n");
	
	while (1)
	{
		xMax++; maxUChar++;
		if (maxUChar < maxUCharOld)
			break;
		maxUCharOld = maxUChar;
	}
	while (1)
	{
		xMin++; minUChar--;
		if (minUChar > minUCharOld)
			break;
		minUCharOld = minUChar;
	}
	while (1)
	{
		yMax++; maxSChar++;
		if (maxSChar < maxSCharOld)
			break;
		maxSCharOld = maxSChar;
	}
	while (1)
	{
		yMin++; minSChar--;
		if (minSChar > minSCharOld)
			break;
		minSCharOld = minSChar;
	}
	
	printf("%d %d %d\n",x1,maxUChar,xMax);
	printf("%d %d %d\n\n",x1,minUChar,xMin);
	printf("%d %d %d\n",y1,maxSChar,yMax);
	printf("%d %d %d\n",y1,minSChar,yMin);
}
