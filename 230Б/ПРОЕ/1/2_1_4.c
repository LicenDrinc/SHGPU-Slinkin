#include <stdio.h>
#include <limits.h>
#include <math.h>

int main(int argc, char **argv)
{
	int i, i1;
	
	scanf("%d",&i);
	printf("\n");
	
	char array[i];
	
	int inspector = 0;
	char data;
	
	int chek = 1;
	int chek1 = 0;
	
	scanf("%hhd",&data);
	array[0] = data;
	for (i1 = 1; i1 <= i - 1; i1++)
	{
		scanf("%hhd",&data);
		array[i1] = data;
		chek1 += 1 - 4 * (chek1 == 4);// 1 2 3 4 1 2 3 4
		chek = (chek1 <= 2) - (chek1 > 2);// 1 1 -1 -1 1 1 -1 -1
		inspector += (array[i1] - array[i1 - 1]) * chek - 1 < 0;
	}
	
	if (inspector == 0)
		printf("\nYes");
	else
		printf("\nNo");
}
