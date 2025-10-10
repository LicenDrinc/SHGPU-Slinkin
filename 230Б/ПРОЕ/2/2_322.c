#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	int m, n;
	scanf("%d\n%d",&m,&n);
	
	int maxN = 0, maxS = 0;
	for (int i = n; i >= m; i--)
	{
		int test = 0;
		int fi = fabs(i);
		float sfi = sqrtf(fi);
		
		if (fabs(sfi - (int)sfi) < 0.0000001) test += sfi;
		
		for (int j = 1; j < sfi; j++)
			if (fi % j == 0)
				test += fi/j + j;
		if (maxS < test)
		{
			maxS = test;
			maxN = i;
		}
	}
	printf("\n%d %d\n",maxN,maxS);
}
