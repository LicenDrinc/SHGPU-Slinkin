#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int i, n, maxx;
	int LD[100];
	FILE *LDf = fopen("LDf.txt", "r");
	n = maxx = 0;
	for (i = 0; i <= 99; i++)
	{
		fscanf(LDf, "%d", &LD[i]);
		maxx = maxx < LD[i] ? LD[i] : maxx;
		printf("%d ", LD[i]);
		if (!(fabs((int)((i + 1) / 10) - n) < 0.000001))
		{
			n++;
			printf("\n");
		}
	}
	printf("\n");
	n = 0;
	for (i = 0; i <= 99; i++)
	{
		LD[i] = fabs(fabs(LD[i]) - maxx) < 0.0000001 ? 1 : 0;
		printf("%d ", LD[i]);
		if (!(fabs((int)((i + 1) / 10) - n) < 0.000001))
		{
			n++;
			printf("\n");
		}
	}
	printf("\n%d\n",maxx);
	return 0;
}