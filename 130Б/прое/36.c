#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float a, b, c;
	scanf("%f\n%f\n%f", &a, &b, &c);
	if (a < b && b < c)
		printf("a<b<c:   Yes\n");
	if ((a < b || fabs(a - b) < 0.000001) && (b < c || fabs(b - c) < 0.000001))
		printf("a<=b<=c: Yes\n");
	if ((a > b || fabs(a - b) < 0.000001) && (b > c || fabs(c - b) < 0.000001))
		printf("a>=b>=c: Yes\n");
	return 0;
}
