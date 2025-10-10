#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float x, y, z;
	scanf("%f\n%f\n%f", &x, &y, &z);
	if (fabs(x - z) < 0.000001 || fabs(z - y) < 0.000001 || fabs(x - y) < 0.000001)
		printf("ERROR ABOUT REPEATING PAIRWISE DISTINCT REAL NUMBERS\n");
	else {
		printf("%f %f %f\n", x, y, z);
		if (x + y + z < 1) {
			if (x < y && x < z)
				x = (y + z) / 2.0;
			else if (y < x && y < z)
				y = (x + z) / 2.0;
			else
				z = (y + x) / 2.0;
		}
		else {
			if (x < y)
				x = (y + z) / 2.0;
			else
				y = (x + z) / 2.0;
		}
		printf("%f %f %f\n", x, y, z);
	}
	return 0;
}
