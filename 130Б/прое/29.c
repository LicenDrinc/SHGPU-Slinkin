#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float x,y,z,z1;
	scanf("%f\n%f", &x,&y);
	z = 3*x*x*y*y-2*x*y*y-7*x*x*y-4*y*y+15*x*y+2*x*x-3*x+10*y+6;
	z1 = y*(y*(x*(3*x-2)-4)+x*(-7*x+15)+10)+x*(2*x-3)+6;
	printf("%f\n%f\n",z1,z);
	return 0;
}
