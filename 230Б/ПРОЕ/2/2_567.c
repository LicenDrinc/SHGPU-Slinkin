#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	int n; scanf("%d",&n);
	
	long long int m = 1;
	for (int i = 1; i <= n; i++)
		m *= i;
	
	int sqr = powf(m,1.0/3);
	for (int i = sqr; i > 0; i--)
	{
		if (m == i*(i+1)*(i+2))
		{
			printf("%d %d %d\n",i,(i+1),(i+2));
			break;
		}
	}
}
