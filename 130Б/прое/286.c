#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int i, n, maxx = -9999999;
	scanf("%d", &n);
	float LD[n];
	for (i = 0; i <= n - 1; i++)
	{
		scanf("%f", &LD[i]);
		maxx = (maxx < LD[i]) ? LD[i] : maxx;
	}
	printf("-----\n");
	for (i = 0; i <= n - 1; i++)
		if (fabs(LD[i] - maxx) < 0.00000001)
			scanf("%f", &LD[i]);
	for (i = 0; i <= n - 1; i++)
		printf("%f\n", LD[i]);
	return 0;
}