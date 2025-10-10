#include <stdio.h>
#include <stdlib.h>

union temp{
	unsigned char x;
	struct {
		unsigned char b01:2;
		unsigned char b23:2;
		unsigned char b45:2;
		unsigned char b67:2;
	} b2;
	struct {
		unsigned char b0:1;
		unsigned char b1:1;
		unsigned char b2:1;
		unsigned char b3:1;
		unsigned char b4:1;
		unsigned char b5:1;
		unsigned char b6:1;
		unsigned char b7:1;
	} b;
};

int main(int argc, char **argv)
{
	union temp z;
	
	scanf("%hhd",&z.x);
	
	printf("%d %d %d %d\n",z.b2.b01,z.b2.b23,z.b2.b45,z.b2.b67);
	
	printf("%d %d %d %d %d %d %d %d\n",
	z.b.b0,z.b.b1,z.b.b2,z.b.b3,z.b.b4,z.b.b5,z.b.b6,z.b.b7);
	
	return 0;
}

