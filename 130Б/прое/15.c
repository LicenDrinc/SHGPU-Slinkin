#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float g,k,k1;
	scanf("%f\n%f",&g,&k);
	k1=sqrtf(g*g-k*k);
	printf("%f\n",k1);
	printf("%f\n",(k*k1)/(k+k1+g));
	printf("%f\n",g/2);
	return 0;
}
