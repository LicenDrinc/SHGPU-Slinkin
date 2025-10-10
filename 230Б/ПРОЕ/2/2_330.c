#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	int n; scanf("%d",&n);
	
	for (int i = 2; i <= n; i++)
	{
		int sum = 1;
		float si = sqrtf(i);
		
		if (fabs((int)si - si) < 0.0000001) sum += si;
		
		for (int j = 2; j < si; j++)
			if (i % j == 0)
				sum += j + i/j;
		if (sum == i)
			printf("%d ",i);
	}
	printf("\n");
}
