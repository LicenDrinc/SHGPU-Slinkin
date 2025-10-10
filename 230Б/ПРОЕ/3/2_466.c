#include <stdio.h>
#include <math.h>

void replacing1And0(char* n, int start, int end, int lin)
{
	if (start < 0) start = 0;
	if (start > lin) start = lin;
	if (end < 0 || end > lin) end = lin;
	if (start > end)
	{
		printf("начало больше чем конец\n");
		return;
	}
	for (int i = start; i <= end; i++)
	{
		if (n[i] == '0') n[i] = '1';
		else if (n[i] == '1') n[i] = '0';
	}
}

int main(int argc, char **argv)
{
	printf("строка до 100: ");
	char str[100]; int lin = 99;
	for (int i = 0; i < 100; i++)
	{
		scanf("%c",&str[i]);
		if (str[i] == '\n')
		{
			lin = i - 1;
			str[i] = 0;
			break;
		}
	}
	int start, end;
	printf("начало: "); scanf("%d",&start);
	printf("конец: "); scanf("%d",&end);
	
	replacing1And0(str,start,end,lin);
	printf("\n%s\n",str);
}
