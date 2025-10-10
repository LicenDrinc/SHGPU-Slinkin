#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <math.h>

struct point
{
	int x; int y;
};

struct box
{
	int xL, xR, yD, yU;
	int cR, cG, cB;
};

int lenStr(char *c1)
{
	int len = 0;
	for (int i = 0; c1[i] != 0; i++)
		len = i + 1;
	return len;
}

int strInInt(char *c1, int len)
{
	int x = 0; int y = c1[0] == '-' ? -1 : 1;
	for (int i = y == -1 ? 1 : 0; i < len; i++)
		x += y*(c1[i] - '0')*powf(10,len-i-1);
	return x;
}

char** memoryAllocationChar(int x, int y)
{
	char **c1 = (char **)malloc(y * sizeof(char *));
	for (int i = 0; i < y; i++)
		c1[i] = (char *)malloc(x * sizeof(char));
	return c1;
}

int main(int argc, char **argv)
{
	struct point image = {0,0};
	
	scanf("%d",&image.x);
	scanf("%d",&image.y);
	
	printf("%d %d\n",image.x,image.y);
}
