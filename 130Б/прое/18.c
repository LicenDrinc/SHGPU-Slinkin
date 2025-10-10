#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float y1, y2, y3, r;
	scanf("%f\n%f\n%f\n%f", &y1, &y2, &y3, &r);
	printf("%f\n%f\n%f\n",2*r*sin(y1*M_PI/180),2*r*sin(y2*M_PI/180),2*r*sin(y3*M_PI/180));
	return 0;
}
