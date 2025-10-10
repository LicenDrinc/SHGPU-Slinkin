#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	float x,y,z;
	scanf("%f\n%f\n%f",&x,&y,&z);
	printf("%f\n",y+x/(y*y+fabs((x*x)/(y+x*x*x/3))));
	printf("%f\n",1+tan(z/2)*tan(z/2));
	printf("%f\n",(2*cos(x-M_PI/6))/(0.5+sin(y)*sin(y)));
	printf("%f\n",1+z*z/(3+z*z/5));
	return 0;
}
