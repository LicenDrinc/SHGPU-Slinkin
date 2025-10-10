#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	int n; scanf("%d",&n);
	int m; scanf("%d",&m);
	
	for (int i = n; i <= m; i++)
	{
		int sum = 1;
		float sfi = sqrtf(i);
		
		if (fabs((int)sfi - sfi) < 0.0000001) sum += sfi;
		
		for (int j = 2; j <= sfi; j++)
			if (i % j == 0)
				sum += j + i/j;
		
		for (int i1 = i; i1 <= m; i1++)
		{
			int sum1 = 1;
			float sfi1 = sqrtf(i1);
			
			if (fabs((int)sfi1 - sfi1) < 0.0000001) sum1 += sfi1;
			
			for (int j1 = 2; j1 <= sfi1; j1++)
				if (i1 % j1 == 0)
					sum1 += j1 + i1/j1;
			if (sum1 == sum && sum != 1 && i != i1)
				printf("%d %d | %d %d\n",i,i1,sum,sum1);
		}
	}
}
