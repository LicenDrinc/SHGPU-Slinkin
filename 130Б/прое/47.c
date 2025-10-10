#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float x, y, z, y1, y2, y3;
	scanf("%f\n%f\n%f", &x, &y, &z);
	if (x+y>z && x+z>y && z+y>y 
		&& !(fabs(x+y-z)<0.000001) && !(fabs(x-y+z)<0.000001) 
		&& !(fabs(-x+y+z)<0.000001))
	{
		y1 = acos((y * y + z * z - x * x) / (2 * y * z)) * 180 / M_PI;
		y2 = acos((x * x + z * z - y * y) / (2 * x * z)) * 180 / M_PI;
		y3 = 180 - y1 - y2;
		printf("triangle is true\n");
		if ((fabs(x - y) < 0.000001) || (fabs(z - y) < 0.000001) || (fabs(x - z) < 0.000001))
			printf("равнобедреный triangle\n");
		if (fabs(x - y) < 0.000001 && fabs(y - z) < 0.000001)
			printf("равностороний triangle\n");
		if (fabs(y1 - 90) < 0.000001 || fabs(y2 - 90) < 0.000001 || fabs(y3 - 90) < 0.000001)
			printf("прямоугольный triangle\n");
		if (y1 < 90 && y2 < 90 && y3 < 90)
			printf("остроугольный triangle\n");

		printf("%f %f %f\n", x, y, z);
		printf("%f %f %f\n", y1, y2, y3);
	}
	else
		printf("triangle is a lie\n");
	return 0;
}
