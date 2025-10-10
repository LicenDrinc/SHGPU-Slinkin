#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float r1,r2,r3;
	scanf("%f\n%f\n%f",&r1,&r2,&r3);
	printf("%f\n",1/(1/r1+1/r2+1/r3));
	printf("%f\n",r1+r2+r3);
	return 0;
}
