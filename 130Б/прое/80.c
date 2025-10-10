#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float x, n, i, z = 0, h = 1;
	int boool = 1;
	scanf("%f\n%f", &x, &n);
	for (i = 1; i <= n; i+=2)
	{
		h *= (fabs(i-1)<0.00001) ? i : i * (i - 1);
		z = z + boool * (powf(x, i) / h);
		boool = -boool;
		printf("%f %f\n",h,z);
	}
	printf("%f\n", z);
	return 0;
}
