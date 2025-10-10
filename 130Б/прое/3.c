#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float a;
	scanf("%f",&a);
	printf("%f\n",a*a*a);
	printf("%f\n",6*a*a);
	printf("%f\n",a*sqrtf(3));
	return 0;
}
