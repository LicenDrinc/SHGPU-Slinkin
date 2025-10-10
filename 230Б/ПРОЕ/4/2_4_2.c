#include <stdio.h>
#include <ctype.h>

int main(int argc, char **argv, char **env)
{
	if (argc < 2)
	{
		printf("./2_4_2 name\n");
		printf("name - полное название переменой\n");
		return 0;
	}
	
	for (int o = 1; o < argc; o++)
	{
		int len = 0;
		for (int i = 0; argv[o][i] != 0; i++)
			len = i+1;

		int flag1 = 0;
		for (int i = 0; env[i] != 0; i++)
		{
			int lenEnv = 0;
			for (int j = 0; env[i][j] != '='; j++)
				lenEnv = j+1;

			if (len != lenEnv)
				continue;
			
			int flag = 0;
			for (int l = 0; l < len; l++)
				if (tolower(argv[o][l]) == tolower(env[i][l])) flag++;
			if (flag == len)
			{
				printf("%s\n---------\n",env[i]);
				flag1++;
			}
		}
		if (!flag1)
		{
			for (int i = 0; argv[o][i] != 0; i++)
				printf("%c",toupper(argv[o][i]));
			printf("=\n---------\n");
		}
	}
}
