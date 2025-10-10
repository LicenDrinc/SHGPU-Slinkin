#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int n;
	float i, z = 0, j, h = 1, f = 1;
	scanf("%d", &n);
	for (i = 1; i <= n; i++)
	{
		for (j = f+1; j <= 2 * i; j++)
			h *= j;
		h /= (fabs(i - 1) < 0.000001) ? 1 : i - 1;
		z += h;
		f = 2 * i;
	}
	printf("%f\n", z);
	printf("%f\n", 1.0*2 + 2*3*4 + 3*4*5*6 + 4*5*6*7*8);
	return 0;
}
