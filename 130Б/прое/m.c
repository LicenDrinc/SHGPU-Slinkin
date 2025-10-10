#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float y, x, i;
	for (x = -10000; x <= 10000; x++)
	{
		for (y = -10000; y <= 10000; y++)
		{
			i = (x/100 - y/100) / (1 + x/100 * y/100);
			if (i == 0.5)
				printf("%f\n%f\n \n", x/100, y/100);
		}
	}
	return 0;
}
