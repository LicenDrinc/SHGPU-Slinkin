#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	int i = 0, j = 9999;
	scanf("%d\n%d",&i,&j);
	
	int x1, x2, y1, y2;
	for (int n = i; n < j; n++)
	{
		int flag = 0;
		int c = powf(n,1/3.0) + 1;
		for (int y = 0; y <= c; y++)
		{
			int y3 = y*y*y;
			for (int x = y; x <= c; x++)
				if (fabs(n) == x*x*x + y3)
				{
					if (flag == 0)
					{
						x1 = x; y1 = y;
					}
					else if (flag == 1)
					{
						x2 = x; y2 = y;
					}
					flag++;
				}
		}
		if (flag > 1)
		{
			printf("%d\n1) x=%d y=%d\n2) x=%d y=%d\n",n,x1,y1,x2,y2);
			break;
		}
	}
}
