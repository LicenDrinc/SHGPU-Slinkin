#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int i, min = 99999999, c = 0, b = 0;
	int LD[20];
	for (i = 0; i <= 19; i++)
	{
		scanf("%d", &LD[i]);
		min = (LD[i] < min) ? LD[i] : min;
		c += LD[i];
	}
	for (i = 0; i <= 19; i++)
		b = (fabs(min - LD[i]) < 0.0000001) ? i : b;
	LD[b] = c / 20;
	printf("\n--------\n%d\n--------\n\n",LD[b]);
	for (i = 0; i <= 19; i++)
	{
		if (b==i)
			printf("%d     <--------\n", LD[i]);
		else
			printf("%d\n", LD[i]);
	}
	return 0;
}