#include <stdio.h>
#include <math.h>

int main(int argc, char** argv)
{
	int i, n, slof, slow = 0;
	scanf("%d", &n);
	char LD[n+1], g;
	scanf("%c", &g);
	for (i = 0; i <= n; i++)
		scanf("%c", &LD[i]);
	LD[n] = ' ';

	for (i = 0; i <= n - 1; i++)
	{
		if (LD[i] == ' ' && i == 0)
		{
			slof = 0; printf("0");
		}
		else if (i == 0 && LD[1] != ' ')
		{
			g = LD[i]; slof = 1; printf("1");
		}
		else if (i == 0)
		{
			slof = 1; printf("2");
		}
		else if ((LD[i - 1] == ' ' && LD[i] != ' ' && LD[i + 1] != ' '))
		{
			g = LD[i]; slof++; printf("3");
		}
		else if (LD[i - 1] == ' ' && LD[i] != ' ' && LD[i + 1] == ' ')
		{
			g = LD[i]; slof++; printf("4");
		}
		else if (LD[i - 1] != ' ' && LD[i] != ' ' && LD[i + 1] == ' ')
		{
			if (g == LD[i])
			{
				slow++; printf("5");
			}
			else
				printf("6");
		}
		else if (LD[i]!=' ')
			printf("7");
		else
			printf(" ");
	}
	printf("\n%d %d %d\n", slof, slow, i);
	return 0;
}