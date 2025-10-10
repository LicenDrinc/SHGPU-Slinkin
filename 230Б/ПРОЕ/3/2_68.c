#include <stdio.h>
#include <math.h>

int idealNumber(int n)
{
	return (n%10) == (n/1000) && (n/10%10) == (n/100%10);
}

int main(int argc, char **argv)
{
	int n = -1;
	while (!(n >= 0 && n < 10000))
		scanf("%d",&n);
		
	printf("%s\n",idealNumber(n)?"да":"нет");
}
