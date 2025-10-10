#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

void writeMatr(int **matr, int N)
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
			printf("%d ",matr[i][j]);
		printf("\n");
	}
}
void zeroMatr(int **matr, int N)
{
	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
			matr[i][j] = 0;
}
void rendomMatr(int **matr, int N)
{
	srand(time(NULL));
	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
			matr[i][j] = rand() % 100;
}
void readMatr(int **matr, int N)
{
	int x = -1; int y = -1;
	while (x < 0 || x >= N || y < 0 || y >= N)
	{
		printf("x: "); scanf("%d", &x);
		printf("y: "); scanf("%d", &y);
	}
	printf("m[%d][%d]: ",x,y); scanf("%d",&matr[y][x]);
}
void turnMatr(int **matr, int N)
{
	int x = 0;
	printf("\n1: против чесовой\n");
	printf("2: по чесовой\n");
	while (x > 2 || x < 1)
		scanf("%d",&x);
	
	int N1 = N - 1;
	int matr1[N][N];
	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
			matr1[x == 1 ? (N1 - j) : j][x == 1 ? i : (N1 - i)] = matr[i][j];
	
	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
			matr[i][j] = matr1[i][j];
}
void transposeMatr(int **matr, int N)
{
	int matr1[N][N];
	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
			matr1[j][i] = matr[i][j];
	
	for (int i = 0; i < N; i++)
		for (int j = 0; j < N; j++)
			matr[i][j] = matr1[i][j];
}

int main(int argc, char **argv)
{
	int N = 0; scanf("%d",&N);
	
	int **matr = (int **)malloc(N * sizeof(int *));
	for (int i = 0; i < N; i++)
		matr[i] = (int *)malloc(N * sizeof(int));
	
	zeroMatr(matr,N);
	printf("\n1: Вывести содержимое матрицы\n");
	printf("2: Обнулить матрицу\n");
	printf("3: Заполнить матрицу случайными значениями\n");
	printf("4: Изменить элемент матрицы по его координатам\n");
	printf("5: Повернуть матрицу на 90 градусов\n");
	printf("6: Транспонировать матрицу\n");
	printf("0: Завершить работу с программой\n");
	while (1)
	{
		printf("------\nЧто сделать: ");
		int c; scanf("%d", &c);
		switch (c)
		{
			case 1: writeMatr(matr, N); break;
			case 2: zeroMatr(matr, N); break;
			case 3: rendomMatr(matr, N); break;
			case 4: readMatr(matr, N); break;
			case 5: turnMatr(matr, N); break;
			case 6: transposeMatr(matr, N); break;
			case 0: goto stop0; break;
			default: break;
		}
	}
	
	stop0: printf("конец\n");
	for (int i = 0; i < N; i++)
		free(matr[i]);
	free(matr);
}
