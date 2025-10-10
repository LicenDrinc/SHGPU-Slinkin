#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float x,y,z;
	scanf("%f", &x);
	printf("%f\n",y = x * x);
	printf("%f\n",z = y * y * x);
	printf("%f\n",z * z * z * y);
	return 0;
}
