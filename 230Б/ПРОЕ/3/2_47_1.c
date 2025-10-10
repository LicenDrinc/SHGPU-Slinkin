#include <stdio.h>
#include <math.h>

#define EXA_PART(a, b, c) ((a) < (b) + (c))
#define TRUE_TRIANGLE(x, y, z) (EXA_PART((x),(y),(z)) && EXA_PART((y),(x),(z)) && EXA_PART((z),(y),(x)))

#define FORMULA_ANGLES(a, b, c) (acos(((b) * (b) + (c) * (c) - (a) * (a)) / (2 * (b) * (c))) * 180 / M_PI)
#define TRUE_ACUTE_ANGLED(x, y, z) (FORMULA_ANGLES((x), (y), (z)) < 90 && FORMULA_ANGLES((y), (x), (z)) < 90 && FORMULA_ANGLES((z), (y), (x)) < 90)

int main(int argc, char **argv)
{
	float x; scanf("%f",&x);
	float y; scanf("%f",&y);
	float z; scanf("%f",&z);
	
	printf("треугольник%s существует\n",TRUE_TRIANGLE(x,y,z)?"":" не");
	
	if (TRUE_TRIANGLE(x,y,z))
		printf("треугольник%s остроугольный\n", TRUE_ACUTE_ANGLED(x,y,z)?"":" не");
}
