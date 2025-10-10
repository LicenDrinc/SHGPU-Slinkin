#include <stdio.h>
#include <limits.h>
#include <math.h>

int main(int argc, char **argv)
{
	unsigned char x, y;
	signed char x0, y0;
	int xMax, xMin, yMax, yMin;
	
	scanf("%hhu\n%hhd\n%hhu\n%hhd",&x,&x0,&y,&y0);
	
	unsigned char maxUChar, minUChar, x1;
	signed char maxSChar, minSChar, y1;
	
	unsigned char maxUCharOld, minUCharOld;
	signed char maxSCharOld, minSCharOld;
	
	printf("\n");
	for (int i = 1; i<=2; i++)
	{
		xMax = 0; xMin = 0; yMax = 0; yMin = 0;
		
		maxSChar = x0; minSChar = x0; y1 = x0;
		maxUChar = x; minUChar = x; x1 = x;
		
		maxUCharOld = maxUChar; minUCharOld = minUChar;
		maxSCharOld = maxSChar; minSCharOld = minSChar;
		
		if ((y != 0 && i == 1) || (y0 != 0 && i == 2))
		{
			while (1)
			{
				xMax++; maxUChar += i == 1 ? y : y0;
				if ((maxUChar < maxUCharOld && (i == 1 ? y > 0 : y0 > 0)) 
				|| (maxUChar > maxUCharOld && (i == 1 ? y < 0 : y0 < 0)))
					break;
				maxUCharOld = maxUChar;
			}
			while (1)
			{
				xMin++; minUChar -= i == 1 ? y : y0;
				if ((minUChar > minUCharOld && (i == 1 ? y > 0 : y0 > 0))
				|| (minUChar < minUCharOld && (i == 1 ? y < 0 : y0 < 0)))
					break;
				minUCharOld = minUChar;
			}
			while (1)
			{
				yMax++; maxSChar += i == 1 ? y : y0;
				if ((maxSChar < maxSCharOld && (i == 1 ? y > 0 : y0 > 0))
				|| (maxSChar > maxSCharOld && (i == 1 ? y < 0 : y0 < 0)))
					break;
				maxSCharOld = maxSChar;
			}
			while (1)
			{
				yMin++; minSChar -= i == 1 ? y : y0;
				if ((minSChar > minSCharOld && (i == 1 ? y > 0 : y0 > 0))
				|| (minSChar < minSCharOld && (i == 1 ? y < 0 : y0 < 0)))
					break;
				minSCharOld = minSChar;
			}
			if (i == 1)
				printf("unsigned x, unsigned y\n\n");
			else
				printf("unsigned x, signed y\n\n");
			printf("x + y\n");
			printf("%d %d %d\n\n",x1,maxUChar,xMax);
			printf("x - y\n");
			printf("%d %d %d\n\n",x1,minUChar,xMin);
			if (i == 1)
				printf("signed x, unsigned y\n\n");
			else
				printf("signed x, signed y\n\n");
			printf("x + y\n");
			printf("%d %d %d\n\n",y1,maxSChar,yMax);
			printf("x - y\n");
			printf("%d %d %d\n\n",y1,minSChar,yMin);
		}
		else
		{
			printf("infinity\n\n");
		}
	}
}
