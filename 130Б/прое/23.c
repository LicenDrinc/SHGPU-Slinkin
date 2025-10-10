#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float t1, t2, t3;
	scanf("%f\n%f\n%f", &t1, &t2, &t3);
	float p = t1+t2+t3;
	float s = sqrtf(p/2*(p/2-t1)*(p/2-t2)*(p/2-t3));
	printf("%f\n%f\n%f\n\n",
	s*2/t1,
	s*2/t2,
	s*2/t3);
	
	printf("%f\n%f\n%f\n\n",
	sqrtf(2*(t2*t2+t3*t3)-t1*t1)/4,
	sqrtf(2*(t1*t1+t3*t3)-t2*t2)/4,
	sqrtf(2*(t2*t2+t1*t1)-t3*t3)/4);
	
	printf("%f\n%f\n%f\n\n",
	sqrtf(t2*t3-(t1*t1*t2*t3)/((t2+t3)*(t2+t3))),
	sqrtf(t1*t3-(t1*t2*t2*t3)/((t1+t3)*(t1+t3))),
	sqrtf(t2*t1-(t1*t3*t2*t3)/((t2+t1)*(t2+t1))));
	return 0;
}
