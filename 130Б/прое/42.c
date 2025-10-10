#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float x, y, z, a, b;
	scanf("%f\n%f\n%f", &x, &y, &z);
	if (fabs(x - z) < 0.000001 || fabs(z - y) < 0.000001 || fabs(x - y) < 0.000001)
		printf("Stop\n");
	else {
		a = (x + z + y) / 2.0;
		b = x * y * z;
		printf("%f %f %f\n", x, y, z);
		if (x < y && x < z) {
			if (y > z)
				y = b;
			else
				z = b;
			x = a;
		}
		else if (y < x && y < z) {
			if (x > z)
				x = b;
			else
				z = b;
			y = a;
		}
		else {
			if (x > y)
				x = b;
			else
				y = b;
			z = a;
		}
		printf("%f %f %f\n", x, y, z);
	}
	return 0;
}
