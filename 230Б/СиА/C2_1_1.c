#include <stdio.h>

const int constX = 10, constY = 10;
int max = 0;
/*
unsigned char array[10][10] =
{
	"0011011111",
	"1101001100",
	"0100000010",
	"0101010100",
	"0001010000",
	"1001011001",
	"0111010110",
	"0001010000",
	"0111011100",
	"1000000010"
};
*/

unsigned char array[10][10] =
{
	"0010001000",
	"0010101000",
	"0100100100",
	"0011111000",
	"0000000000",
	"0000000000",
	"0000000000",
	"0000000000",
	"0000000000",
	"0000000000"
};


void outArray()
{
	for (int y = 0; y < constY; y++)
	{
		for (int x = 0; x < constX; x++)
			printf("%c", array[y][x]);
		printf("\n");
	}
};

void fill4(int x, int y, int max1)
{
	if (x > constX - 1 || x < 0 || y > constY - 1 || y < 0 || array[y][x] != '0')
	{
		max = max < max1 ? max1 : max;
		return;
	}
	array[y][x] = '*';
	
	fill4(x + 1, y, max1 + 1);
	fill4(x - 1, y, max1 + 1);
	fill4(x, y + 1, max1 + 1);
	fill4(x, y - 1, max1 + 1);
};

void fill3(int x, int y, int max1)
{
	reset: ;
	if (x > constX - 1 || x < 0 || y > constY - 1 || y < 0 || array[y][x] != '0')
	{
		max = max < max1 ? max1 : max;
		return;
	}
	array[y][x] = '*';
	/*
	outArray();
	printf("\n%d\n\n",max1);
	*/
	fill3(x + 1, y, max1 + 1);
	fill3(x - 1, y, max1 + 1);
	fill3(x, y + 1, max1 + 1);
	//fill3(x, y - 1, max1 + 1);
	
	//x++;
	//x--;
	//y++;
	y--;
	goto reset;
};

void fill2(int x, int y, int max1)
{
	if (x > constX - 1 || x < 0 || y > constY - 1 || y < 0 || array[y][x] != '0')
	{
		max = max < max1 ? max1 : max;
		return;
	}
	int xLeft = 0, xRight = constX - 1;
	
	for (int x1 = x; x1 < constX; x1++)
	{
		if (array[y][x1] == '0')
			array[y][x1] = '*';
		else if (array[y][x1] == '1')
		{
			xRight = x1 - 1;
			break;
		}
	}
	for (int x1 = x; x1 >= 0; x1--)
	{
		if (array[y][x1] == '0')
			array[y][x1] = '*';
		else if (array[y][x1] == '1')
		{
			xLeft = x1 + 1;
			break;
		}
	}
	for (int x1 = xLeft; x1 <= xRight; x1++)
	{
		fill2(x1, y + 1, max1 + 1);
		fill2(x1, y - 1, max1 + 1);
	}
};

int main(int argc, char **argv)
{
	fill2(4,0,1);
	outArray();
	printf("\n%d\n",max);
}
