#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	float x1,x2,x3,y1,y2,y3,p,t1,t2,t3;
	scanf("%f\n%f\n%f\n%f\n%f\n%f", &x1,&y1,&x2,&y2,&x3,&y3);
	t1 = sqrtf((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
	t2 = sqrtf((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2));
	t3 = sqrtf((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3));
	p = (t1 + t2 + t3)/2;
	printf("%f\n%f\n",sqrtf(p * (p - t1) * (p - t2) * (p - t3)), p*2);
	return 0;
}
