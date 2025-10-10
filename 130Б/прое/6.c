#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float a,b;
	scanf("%f\n%f",&a,&b);
	printf("%f\n",sqrtf(a*a+b*b));
	printf("%f\n",a*b/2);
	printf("%f\n",(atan(a/b) / M_PI )*180);
	printf("%f\n",(atan(b/a) / M_PI )*180);
	return 0;
}
