#include <stdio.h>
#include <math.h>
#include <stdlib.h>

struct box
{
	int xL, xR, yD, yU;
	unsigned char cR, cG, cB;
};

struct color
{
	unsigned char cR, cG, cB;
};

struct rect_t
{
	int xL, xR, yD, yU;
};

struct color** memoryAllocationStructColor(int x, int y)
{
	struct color** c1 = (struct color**)malloc(y * sizeof(struct color*));
	for (int i = 0; i < y; i++)
		c1[i] = (struct color*)malloc(x * sizeof(struct color));
	return c1;
}

void freeStructColor(struct color** c1, int y)
{
	for (int i = 0; i < y; i++) free(c1[i]);
	free(c1);
}

int sameStructBox(struct box a, struct box b)
{
	return a.xL == b.xL && a.xR == b.xR && 
		a.yD == b.yD && a.yU == b.yU && 
		a.cR == b.cR && a.cG == b.cG && a.cB == b.cB;
}

int sameStructRect_tOr(struct rect_t a, struct rect_t b)
{
	return a.xL == b.xL || a.xR == b.xR || 
		a.yD == b.yD || a.yU == b.yU;
}

int main(int argc, char **argv)
{
	struct rect_t rects[100];
	scanf("%d",&rects[0].xR);
	scanf("%d",&rects[0].yD);
	
	struct color** image = memoryAllocationStructColor(rects[0].xR, rects[0].yD);

	for (int i = 0; i < rects[0].yD; i++)
		for (int j = 0; j < rects[0].xR; j++)
			image[i][j] = (struct color){255, 255, 255};

	for (int z = 1; 1; z++)
	{
		struct box boxColor = {0,0,0,0,0,0,0};
		
		scanf("%d",&boxColor.xL);
		scanf("%d",&boxColor.yU);
		scanf("%d",&boxColor.xR);
		scanf("%d",&boxColor.yD);
		scanf("%hhd",&boxColor.cR);
		scanf("%hhd",&boxColor.cG);
		scanf("%hhd",&boxColor.cB);
		
		if (sameStructBox(boxColor, (struct box){0,0,0,0,0,0,0}))
			break;
		
		rects[z] = (struct rect_t)
			{boxColor.xL, boxColor.xR, boxColor.yD, boxColor.yU};
			
		struct color RGB = (struct color)
			{boxColor.cR, boxColor.cG, boxColor.cB};
		
		for (int i = boxColor.yU-1; i <= boxColor.yD+1; i++)
		{
			for (int j = boxColor.xL-1; j <= boxColor.xR+1; j++)
			{
				if (i >= 0 && j >= 0 && i < rects[0].yD && j < rects[0].xR)
				{
					if (sameStructRect_tOr(rects[z], (struct rect_t){j+1,j-1,i-1,i+1}))
						image[i][j] = (struct color){0, 0, 0};
					else
						image[i][j] = RGB;
				}
			}
		}
	}
	
	printf("P3\n%d %d\n255",rects[0].xR,rects[0].yD);
	for (int i = 0; i < rects[0].yD; i++)
		for (int j = 0; j < rects[0].xR; j++)
			printf("\n%d %d %d",image[i][j].cR,image[i][j].cG,image[i][j].cB);

	freeStructColor(image, rects[0].yD);
}
