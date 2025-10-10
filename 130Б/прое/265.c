#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int i, n;
	scanf("%d", &n);
	char LD[n];
	for (i = 0; i <= n - 1; i++)
	{
		scanf("%c", &LD[i]);
		LD[i] = LD[i] == '*' ? '-' : LD[i];
	}
	for (i = 0; i <= n - 1; i++)
		printf("%c", LD[i]);
	printf("\n");
	return 0;
}