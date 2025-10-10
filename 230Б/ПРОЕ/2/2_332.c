#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	int n; scanf("%d",&n);
	
	int n4 = n/4; 
	int n3 = n4*3, n2 = n4*2;
	for (int x = 0; x*x <= n4; x++)
	{
		int x2 = x*x;
		for (int y = x; y*y + x2 <= n2; y++)
		{
			int y2 = y*y; int xy = x2 + y2;
			for (int z = y; z*z + xy <= n3; z++)
			{
				int z2 = z * z; int xyz = xy + z2;
				for (int t = z; t*t + xyz <= n; t++)
				{
					if (n == xyz + t * t)
						printf("%d %d %d %d\n",x,y,z,t);
				}
			}
		}
	}
}
