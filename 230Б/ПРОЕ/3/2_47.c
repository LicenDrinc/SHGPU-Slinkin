#include <stdio.h>
#include <math.h>

int exaPart(float a, float b, float c)
{
	return a < b + c;
}

int trueTriangle(float x, float y, float z)
{
	return exaPart(x, y, z) && exaPart(y, x, z) && exaPart(z, y, x);
}

float formulaAngles(float a, float b, float c)
{
	return acos((b * b + c * c - a * a) / (2 * b * c)) * 180 / M_PI;
}

int trueAcuteAngled(float x, float y, float z)
{
	return formulaAngles(x, y, z) < 90 && formulaAngles(y, x, z) < 90 && formulaAngles(z, y, x) < 90;
}

int main(int argc, char **argv)
{
	float x; scanf("%f",&x);
	float y; scanf("%f",&y);
	float z; scanf("%f",&z);
	/*
	printf("%f",formulaAngles(x,y,z));
	return 0;
	*/
	printf("треугольник%s существует\n", trueTriangle(x,y,z)?"":" не");
	
	if (trueTriangle(x,y,z))
		printf("треугольник%s остроугольный\n",trueAcuteAngled(x,y,z)?"":" не");
}
