#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct color
{
	unsigned char cR, cG, cB;
};

struct square_t
{
	int x, y, d;
};

struct color** memoryAllocationStructColor(int x, int y)
{
	struct color **c1 = (struct color **)malloc(y * sizeof(struct color *));
	for (int i = 0; i < y; i++)
		c1[i] = (struct color *)malloc(x * sizeof(struct color));
	return c1;
}

void freeStructColor(struct color **image, int y)
{
	for (int i = 0; i < y; i++) free(image[i]);
	free(image);
}

void kovor(struct color **image, struct square_t pole, int inter, int interOrig, struct color colorBox)
{
	if (inter >= interOrig)
		return;
	
	struct square_t POB = {pole.x+pole.d/3, pole.y+pole.d/3, pole.d/3};
	int yD = POB.y + POB.d, xD = POB.x + POB.d;
	for (int i = POB.y; i < yD; i++)
		for (int j = POB.x; j < xD; j++)
			image[i][j] = colorBox;
	
	kovor(image, (struct square_t){pole.x,	pole.y,	POB.d}, inter+1, interOrig, colorBox);
	kovor(image, (struct square_t){POB.x,	pole.y,	POB.d}, inter+1, interOrig, colorBox);
	kovor(image, (struct square_t){xD,		pole.y,	POB.d}, inter+1, interOrig, colorBox);
	kovor(image, (struct square_t){pole.x,	POB.y,	POB.d}, inter+1, interOrig, colorBox);
	kovor(image, (struct square_t){pole.x,	yD,		POB.d}, inter+1, interOrig, colorBox);
	kovor(image, (struct square_t){xD,		POB.y,	POB.d}, inter+1, interOrig, colorBox);
	kovor(image, (struct square_t){POB.x,	yD,		POB.d}, inter+1, interOrig, colorBox);
	kovor(image, (struct square_t){xD,		yD,		POB.d}, inter+1, interOrig, colorBox);
};

int main(int argc, char **argv)
{
	int boxImage; scanf("%d",&boxImage);
	int iterations; scanf("%d",&iterations);
	
	struct color colorBoxOriginal = {0, 0, 0};
	scanf("%hhd",&colorBoxOriginal.cR);
	scanf("%hhd",&colorBoxOriginal.cG);
	scanf("%hhd",&colorBoxOriginal.cB);
	
	struct color colorBox = {0, 0, 0};
	scanf("%hhd",&colorBox.cR);
	scanf("%hhd",&colorBox.cG);
	scanf("%hhd",&colorBox.cB);
	
	struct color **image = memoryAllocationStructColor(boxImage,boxImage);
	for (int i = 0; i < boxImage; i++)
		for (int j = 0; j < boxImage; j++)
			image[i][j] = colorBoxOriginal;
	
	kovor(image, (struct square_t){0,0,boxImage}, 0, iterations, colorBox);
	
	printf("P3\n%d %d\n255",boxImage,boxImage);
	for (int i = 0; i < boxImage; i++)
		for (int j = 0; j < boxImage; j++)
			printf("\n%d %d %d",image[i][j].cR,image[i][j].cG,image[i][j].cB);
	
	freeStructColor(image, boxImage);
}
