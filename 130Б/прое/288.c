#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int i, n, b, z = 1;
	scanf("%d", &n);
	float LD[n];
	float c = 0;
	for (i = 0; i <= n - 1; i++)
	{
		LD[i] = 0;
		while (fabs(LD[i]) < 0.0000001)
			scanf("%f",&LD[i]);
		if (i == 0)
			b = -LD[i] / fabs(LD[i]);
		if (z == 1)
		{
			if ((LD[i] > 0 && b < 0) || (LD[i] < 0 && b > 0))
				b *= -1;
			else
				z = 0;
		}
	}
	if (z == 1)
	{
		for (i = 0; i <= n - 1; i++)
			c += LD[i];
		printf("%f\n", c);
	}
	else
	{
		for (i = 0; i <= n - 1; i++)
		{
			if (LD[i] > 0)
				LD[i] *= -1;
			printf("%f\n", LD[i]);
		}
	}
	return 0;
}