#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	int n; scanf("%d",&n);
	
	int start = powf(10,n-1), end = powf(10,n);
	for (int i = start; i < end; i++)
	{
		int m = 0, num = i;
		for (int j = 0; j < n; j++)
		{
			m += pow((num % 10),n);
			num /= 10;
		}
		if (i == m)
			printf("%d\n",i);
	}
}
