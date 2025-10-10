#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float n, i, z = 0, k = 0;
	scanf("%f", &n);
	for (i = 1; i <= n; i++)
	{
		k += sin(i);
		z = z + 1 / k;
	}
	printf("\n%f\n", z);
	return 0;
}
