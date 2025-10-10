#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float a, b, c, d;
	scanf("%f\n%f\n%f", &a, &b, &c);
	if (fabs(a) < 0.000001)
		printf("where a?\n");
	else
	{
		d = b * b - 4 * a * c;
		if (fabs(d) < 0.000001)
		{
			printf("one root\n");
			printf("%f\n", -b / (2 * a));
		}
		else if (d > 0)
		{
			printf("two roots\n");
			printf("1) %f\n", (-b + sqrtf(d)) / (2 * a));
			printf("2) %f\n", (-b - sqrtf(d)) / (2 * a));
		}
		else
			printf("where are the roots?\n");
	}
	return 0;
}
