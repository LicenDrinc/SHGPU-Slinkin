#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float i, z = 1;
	int n;
	scanf("%d", &n);
	for (i = 1; i <= n*10; i++)
	{
		z *= (1 + sin(i/10));
		printf("%f %f\n", z, 1 + sin(i / 10));
	}
	printf("\n%f\n", z);
	printf("%f\n",(1+sin(0.1))*(1+sin(0.2))*(1+sin(0.3))*(1+sin(0.4))*(1+sin(0.5))*(1+sin(0.6))*(1+sin(0.7))*(1+sin(0.8))*(1+sin(0.9))*(1+sin(1)));
	return 0;
}
