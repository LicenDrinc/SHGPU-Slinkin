#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float a, z = 0, i = 0;
	scanf("%f", &a);
	while (z < a || fabs(z - a) < 0.000001)
		z += 1 / ++i;
	printf("%f\n%f\n", i, z);
	return 0;
}
