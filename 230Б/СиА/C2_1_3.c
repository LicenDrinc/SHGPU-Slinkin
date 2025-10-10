#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char **argv)
{
	int x = 0, y = 0, len = 0, iter = 0, maxN[4];
	char none_ = ' ', paint_ = '*';
	int StrToInt(unsigned char c)
	{
		return c - 48;
	};

	if (argc > 4)
	{
		for (int j = 1; j <= 4; j++)
		{
			for (int i = 0; i <= pow(10,10); i++)
			{
				if (argv[j][i] == 0)
				{
					maxN[j - 1] = i;
					break;
				}
			}
		}
		
		for (int i = 0; i < maxN[0]; i++)
			x += pow(10,maxN[0] - 1 - i) * StrToInt(argv[1][i]);
		for (int i = 0; i < maxN[1]; i++)
			y += pow(10, maxN[1] - 1 - i) * StrToInt(argv[2][i]);
		for (int i = 0; i < maxN[2]; i++)
			len += pow(10, maxN[2] - 1 - i) * StrToInt(argv[3][i]);
		for (int i = 0; i < maxN[3]; i++)
			iter += pow(10, maxN[3] - 1 - i) * StrToInt(argv[4][i]);
		
		//printf("\n%d %d %d %d\n",x,y,len,iter);
	}
	else
	{
		printf("error\n");
		printf("./C2_1_3_herc x y len iter\n");
		return 0;
	}
	
	unsigned char array[y][x];

	for (int y1 = 0; y1 <= y - 1; y1++)
		for (int x1 = 0; x1 <= x - 1; x1++)
			array[y1][x1] = none_;

	void outArray()
	{
		//printf("P1\n%d %d\n",x,y);
		for (int y1 = 0; y1 <= y - 1; y1++)
		{
			for (int x1 = 0; x1 <= x - 1; x1++)
				printf("%c", array[y1][x1]);
			printf("\n");
		}
	};


	void fill(int x0, int y0, int len0, int iter0)
	{
		if (iter0 >= iter)
		{
			return;
		}
		else
		{
			int y0Check = y0 >= 0 && y0 < y;
			
			for (int x1 = x0; x1 <= x0 + round(len0 / 2); x1++)
				if (x1 >= 0 && x1 < x && y0Check) array[y0][x1] = paint_;
			for (int x1 = x0; x1 >= x0 - round(len0 / 2); x1--)
				if (x1 >= 0 && x1 < x && y0Check) array[y0][x1] = paint_;
			
			int x2 = x0 + round(len0 / 2), x3 = x0 - round(len0 / 2);
			int len1 = round(len0 / sqrt(2));
			
			int x2Check = x2 >= 0 && x2 < x;
			int x3Check = x3 >= 0 && x3 < x;
			
			for (int y1 = y0; y1 <= y0 + round(len1 / 2); y1++)
				if (x2Check && y1 >= 0 && y1 < y) array[y1][x2] = paint_;
			for (int y1 = y0; y1 >= y0 - round(len1 / 2); y1--)
				if (x2Check && y1 >= 0 && y1 < y) array[y1][x2] = paint_;
			
			for (int y1 = y0; y1 <= y0 + round(len1 / 2); y1++)
				if (x3Check && y1 >= 0 && y1 < y) array[y1][x3] = paint_;
			for (int y1 = y0; y1 >= y0 - round(len1 / 2); y1--)
				if (x3Check && y1 >= 0 && y1 < y) array[y1][x3] = paint_;
			
			fill(x0 + round(len0 / 2), y0 + round(len1 / 2), round(len1 / sqrt(2)), iter0 + 1);
			fill(x0 - round(len0 / 2), y0 - round(len1 / 2), round(len1 / sqrt(2)), iter0 + 1);
			fill(x0 - round(len0 / 2), y0 + round(len1 / 2), round(len1 / sqrt(2)), iter0 + 1);
			fill(x0 + round(len0 / 2), y0 - round(len1 / 2), round(len1 / sqrt(2)), iter0 + 1);
			//rint
		}
	}

	fill(x / 2, y / 2, len, 0);

	outArray();
	
	return 0;
}

