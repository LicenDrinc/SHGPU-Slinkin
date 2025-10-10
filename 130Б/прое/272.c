#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int LD[88];
	int i, n;
	float s;
	FILE *LDf = fopen("LD.txt", "r");
	for (i = 0; i <= 87; i++)
	{
		fscanf(LDf, "%d", &LD[i]);
		n += LD[i];
	}
	s = n / 88.0;
	printf("\n%.3f\n\n", s);
	for (i = 0; i <= 87; i++)
		printf("%.3f\n", LD[i] - s);
	return 0;
}