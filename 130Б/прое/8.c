#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float n,r;
	scanf("%f\n%f",&n,&r);
	printf("%f\n",2*r*n*tan(M_PI/n));
	printf("%f\n",2*r*n*sin(M_PI/n));
	return 0;
}
