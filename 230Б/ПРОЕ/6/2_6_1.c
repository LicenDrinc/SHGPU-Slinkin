#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	int c_ = 0, l_ = 0, w_ = 0, chek_ = 0, fpLine = 0, flagFP = 0;;
	char** filePath = (char**)malloc(argc * sizeof(char*));

	for (int i = 1; i < argc; i++)
	{
		if (argv[i][0] == '-')
		{
			for (int j = 1; argv[i][j] != 0; j++)
			{
				if (argv[i][j] == 'c')
					chek_ = c_ = 1;
				if (argv[i][j] == 'l')
					chek_ = l_ = 1;
				if (argv[i][j] == 'w')
					chek_ = w_ = 1;
			}
		}
		else
		{
			filePath[fpLine] = argv[i];
			fpLine++;
		}
	}

	if (fpLine == 0)
		fpLine = flagFP++;
	if (!chek_) c_ = l_ = w_ = 1;
	
	for (int i = 0; i < fpLine; i++)
	{
		FILE* f;
		if (flagFP) f = stdin;
		else f = fopen(filePath[i], "r");
		int character, w = 0, l = 0, wCheck = 0;
		long long int c = 0;
		if (f == NULL)
		{
			printf("NULL %s\n", filePath[i]);
			continue;
		}
		while ((character = getc(f)) != EOF)
		{
			if (character == '\n')
				l++;
			if (character >= 33)
				wCheck = 1;
			else if (character < 33 && wCheck)
			{
				w++; wCheck = 0;
			}
		}
		if (wCheck)
			w++;
		fseek(f, 0L, SEEK_END); c = ftell(f);
		if (l_ == 1) printf("%d ", l);
		if (w_ == 1) printf("%d ", w);
		if (c_ == 1) printf("%lld ", c);
		printf("%s\n", flagFP ? "" : filePath[i]);
		fclose(f);
	}
	
	free(filePath);
}
