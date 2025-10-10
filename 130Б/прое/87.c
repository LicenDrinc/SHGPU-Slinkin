#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int n, m, j/*, i = 1, l = 10*/;
	float z = 0;
	scanf("%d\n%d", &n, &m);
	//while (n > l)
	//{
	//	i++;
	//	l *= 10;
	//}
	//for (j = i; j > i - m; j--)
	for (j = 1; j <= m; j++)
	{
		//z += n / (int)(powf(10, j - 1)) - (n / (int)(powf(10, j))) * 10;
		z+=n%10;
		n/=10;
	}
	printf("\n%f\n",z);
	return 0;
}
