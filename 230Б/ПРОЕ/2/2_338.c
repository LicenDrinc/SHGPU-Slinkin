#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
	int n, m;
	printf("n: "); scanf("%d",&n);
	printf("m: "); scanf("%d",&m);
	
	int a[m], b[n];
	
	printf("---[ a[%d] ]---\n",m);
	for (int i = 0; i < m; i++) scanf("%d",&a[i]);
	printf("---[ b[%d] ]---\n",n);
	for (int i = 0; i < n; i++) scanf("%d",&b[i]);
	
	//int u = (m < n ? n : m);
	/*
	int c1[m+n], l1 = 0;
	for (int i = 0; i < m; i++)
	{
		for (int j = 0; j < n; j++)
		{
			int flag = 0;
			for (int z = 0; z < l1; z++)
				if (c1[z] == a[i])
					flag++;
			if (a[i] == b[j] && flag == 0)
			{
				c1[l1] = a[i]; l1++;
			}
		}
	}
	
	printf("[ ");
	for (int i = 0; i < l1; i++)
		printf("%d ",c1[i]);
	printf("]\n");
	*/
	/*
	printf("\nb+a\n[");
	int c[m+n], l = 0;
	for (int i = 0; i < m + n; i++)
	{
		int k = 0, f = i < m ? a[i] : b[i - m];
		for (int j = 0; j <= l; j++)
		{
			if (c[j] != f)
				k++;
			else break;
		}
		if (k == l + 1)
		{
			c[l] = f;
			printf(" %d",c[l]);
			l++;
		}
	}
	printf(" ]\n");
	*/
	
	printf("\nb-a\n[ ");
	int c2[m+n], l2 = 0;
	for (int i = 0; i < n; i++)
	{
		int k = 0;
		for (int j = 0; j < m; j++)
		{
			int flag = 0;
			for (int z = 0; z < l2; z++)
				if (c2[z] == b[i])
					flag++;
			if (a[j] != b[i] && flag == 0)
				k++;
		}
		if (k == m)
		{
			c2[l2] = b[i]; l2++;
		}
	}
	
	for (int i = 0; i < l2; i++)
		printf("%d ",c2[i]);
	printf("]\n");
	
}
