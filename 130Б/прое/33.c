#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float x, y;
	scanf("%f\n%f",&x,&y);
	if (fabs(x-y)<0.000001)
		printf("x(%f) and y(%f) => max and min",x,y);
	else if (x > y)
		printf("max x(%f), min y(%f)",x,y);
	else
		printf("max y(%f), min x(%f)",y,x);
	return 0;
}
