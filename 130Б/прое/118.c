#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int n = 10000000, i, b;
	double z1, z2, z2p1, z2p2, z3, z4, z4p1, z4p2;
	z1 = z2p1 = z2p2 = z3 = z4p1 = z4p2 = 0;
	b = 1;
	for (i = 1; i <= n; i++)
	{
		z1 += b * 1.0 / i;
		b *= -1;
	}

	b = 1;
	for (i = 1; i <= n; i++)
	{
		if (fabs(b - 1) < 0.0000001)
			z2p1 += 1.0 / i;
		else
			z2p2 += 1.0 / i;
		b *= -1;
	}
	z2 = z2p1 - z2p2;

	b = -1;
	for (i = n; i > 0; i--)
	{
		z3 += b * 1.0 / i;
		b *= -1;
	}

	b = -1;
	for (i = n; i > 0; i--)
	{
		if (fabs(b - 1) < 0.0000001)
			z4p1 += 1.0 / i;
		else
			z4p2 += 1.0 / i;
		b *= -1;
	}
	z4 = z4p1 - z4p2;

	printf("%.20f\n%.20f\n%.20f\n%.20f\n%.20f\n%.20f\n", z1, z2, z3, z4, z2p1, z2p2);
	return 0;
}
