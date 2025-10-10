#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int n, i = 1, l = 10, j;
	float z = 0, k;
	scanf("%d", &n);
	while (n > l)
	{
		i++;
		l *= 10;
	}
	k = i % 2;
	for (j = i; j > 0; j--)
		z += powf(-1, j + k) * (n / (int)(powf(10, j - 1)) - (n / (int)(powf(10, j))) * 10);
	printf("%f\n",z);
	return 0;
}