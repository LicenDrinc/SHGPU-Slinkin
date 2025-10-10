#include <stdio.h>
#include <math.h>

#define STRETCHING_STR(s, lin, n)																\
	char str1[(n)];																				\
	int spacesNum = 0, wordsNum = 0;															\
	for (int i = 0; i < (n); i++)																\
	{																							\
		if ((s)[i] == ' ')																		\
			spacesNum++;																		\
		else if ((s)[i] != ' ' && (i == 0 || (s)[i - 1] == ' ') && (s)[i] != 0)					\
			wordsNum++;																			\
		str1[i] = (s)[i];																		\
	}																							\
	if (spacesNum != 0)																			\
	{																							\
		int midSpace = ((n) - *(lin) + spacesNum) / (wordsNum - 1);								\
		for (int i = 1; i <= midSpace && str1[(n) - 1] == 0/* && *(lin) < (n)*/; i++)			\
		{																						\
			int z = 0;																			\
			for (int i1 = 0; i1 <= *(lin) && str1[(n) - 1] == 0/* && *(lin) < (n) */ ; i1++)	\
			{																					\
				if (str1[i1] == ' ' && (i1 != 0 && str1[i1 - 1] != ' '))						\
					z = 1;																		\
				else if (str1[i1] == ' ' && z > 0)												\
					z++;																		\
				else if (str1[i1] != ' ' && (i1 != 0 && str1[i1 - 1] == ' ') && z > 0)			\
				{																				\
					if (z < i)																	\
					{																			\
						for (int i2 = *(lin); i2 >= i1; i2--)									\
							str1[i2 + 1] = str1[i2];											\
						str1[i1] = ' ';															\
						(*(lin))++; i1++;														\
					}																			\
				}																				\
				if (str1[i1] != ' ')															\
					z = 0;																		\
			}																					\
		}																						\
		for (int i = 0; i < (n); i++)															\
			(s)[i] = str1[i];																	\
	}

int inputStr(char* s, int lin)
{
	int lin1 = lin - 1;
	int k = 1;
	for (int i = 0; i < lin; i++)
	{
		if (k)
		{
			scanf("%c", &s[i]);
			if (s[i] == '\n' && i == 0)
				i--;
			else if (s[i] == '\n')
			{
				lin1 = i - 1;
				s[i] = 0;
				k = 0;
			}
		}
		else
			s[i] = 0;
	}
	return lin1;
}


int main(int argc, char **argv)
{
	int n; scanf("%d",&n);
	printf("строка до %d: ",n);
	char str[n]; int lin = inputStr(str, n);
	
	STRETCHING_STR(str, &lin, n);
	//printf("\n%s\n%d\n",str,lin);
	/*
	printf("\n|");
	for (int i = 0; i <= lin; i++)
		printf("%d",i%10);
	printf("|");
	*/
	printf("\n|");
	for (int i = 0; i <= lin; i++)
		printf("%c",str[i]);
	//printf("|\n%d\n",lin + 1);
	printf("|\n");
}
