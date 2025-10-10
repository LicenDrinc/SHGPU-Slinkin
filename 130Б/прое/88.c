#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int n, m = 0, i = 1, l = 10, j;
	scanf("%d", &n);
	while (n > l)
	{
		i++;
		l *= 10;
	}
	for (j = i; j > 0; j--)
	{
		m += (n % 10) * powf(10, j - 1);
		n /= 10;
	}
	n = m;
	printf("%d\n", n);
	return 0;
}
