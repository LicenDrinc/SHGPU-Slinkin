#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int i, n, z;
	scanf("%d", &n);
	float LD[2 * n];
	for (i = 0; i <= 2 * n - 1; i++)
		scanf("%f", &LD[i]);
	for (i = 0; i <= n - 1; i++)
		printf("%f	%f\n", LD[i], LD[2 * n - i - 1]);
	scanf("%d", &z);
	for (i = 0; i <= n - 1; i++)
		printf("%f = %f + %f\n", LD[i] + LD[2 * n - i - 1], LD[i], LD[2 * n - i - 1]);
	return 0;
}