#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float x, y, z;
	scanf("%f\n%f\n%f", &x, &y, &z);
	if (fabs(x - z) < 0.000001)
	{
		if (fabs(x - y) < 0.000001)
			printf("x(%f), y(%f) and z(%f) => max and min\n", x, y, z);
		else if (x > y)
			printf("max x(%f) and z(%f), min y(%f)\n", x, z, y);
		else
			printf("max y(%f), min x(%f) and z(%f)\n", y, x, z);
	}
	else if (z > x)
	{
		if (fabs(x - y) < 0.000001)
			printf("max z(%f), min x(%f) and y(%f)\n", z, x, y);
		else if (x < y && fabs(z - y) < 0.000001)
			printf("max y(%f) and z(%f), min x(%f)\n", y, z, x);
		else if (x > y)
			printf("max z(%f), min y(%f)\n", z, y);
		else if (x < y && y > z)
			printf("max y(%f), min x(%f)\n", y, x);
		else if (x < y && y < z)
			printf("max z(%f), min x(%f)\n", z, x);
		
	}
	else if (z < x)
	{
		if (fabs(x - y) < 0.000001)
			printf("max x(%f) and y(%f), min z(%f)\n", x, y, z);
		else if (x > y && fabs(z - y) < 0.000001)
			printf("max x(%f), min y(%f) and z(%f)\n", x, y, z);
		else if (x > y && z > y)
			printf("max x(%f), min y(%f)\n", x, y);
		else if (x > y && z < y)
			printf("max x(%f), min z(%f)\n", x, z);
		else if (x < y)
			printf("max y(%f), min z(%f)\n", y, z);
	}
	return 0;
}
