#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float y, x;
	scanf("%f\n%f",&x,&y);
	printf("%f\n",(fabs(x)-fabs(y))/(1+fabs(x*y)));
	printf("%f\n",(x-y)/(1+x*y));
	return 0;
}
