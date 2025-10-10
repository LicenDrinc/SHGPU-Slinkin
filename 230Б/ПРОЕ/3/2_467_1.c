#include <stdio.h>
#include <math.h>

#define MINUS_STR(n, n1, lin, lin1)                         \
	for (int i = (lin); i >= 0; i--)                        \
	{                                                       \
		for (int j = 0; j <= (lin1); j++)                   \
		{                                                   \
			if ((n)[i] == (n1)[j])                         \
			{                                               \
				(n)[i] = 0;                                 \
				for (int i1 = i; i1 <= (lin); i1++)         \
				{                                           \
					if ((n)[i1] == 0)                       \
					{                                       \
						if (i1+1 > (lin) || (n)[i1+1] == 0) \
							break;                          \
						(n)[i1] = (n)[i1+1];                \
						(n)[i1+1] = 0;                      \
					}                                       \
				}                                           \
				break;                                      \
			}                                               \
		}                                                   \
	}

int inputStr(char* n, int lin)
{
	int lin1 = lin-1;
	for (int i = 0; i < lin; i++)
	{
		scanf("%c",&n[i]);
		if (n[i] == '\n')
		{
			lin1 = i - 1;
			n[i] = 0;
			break;
		}
	}
	return lin1;
}

int main(int argc, char **argv)
{
	printf("строка до 100: ");
	char str[100]; int lin = inputStr(str, 100);
	printf("строка до 100: ");
	char str1[100]; int lin1 = inputStr(str1, 100);
	
	MINUS_STR(str, str1, lin, lin1);
	
	printf("\n%s\n",str);
}
