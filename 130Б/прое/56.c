#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float a, b, c, x, y, max, max1, maxx, d;
	scanf("%f\n%f\n%f\n%f\n%f", &a, &b, &c, &x, &y);
	if ((a > b || fabs(a - b) < 0.000001) && (a > c || fabs(a - c) < 0.000001))
	{
		max = a;
		max1 = (b > c) ? b : c;
	}
	else if ((b > a || fabs(b - a) < 0.000001) && (b > c || fabs(b - c) < 0.000001))
	{
		max = b;
		max1 = (a > c) ? a : c;
	}
	else
	{
		max = c;
		max1 = (b > a) ? b : a;
	}
	maxx = (x > y) ? y : x;
	d = sqrt(max * max + max1 * max1);
	if (maxx > d || fabs(maxx - d) < 0.000001)
		printf("YES\n");
	else
		printf("NO\n");
	return 0;
}
