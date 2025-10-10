#include <stdio.h>

int find_count;
typedef int (*testfunc)(int);

int line_find_one(const int src[], int src_size, testfunc func)
{
	find_count = 0;
	for (int i = 0; i < src_size; i++)
	{
		find_count++;
		if (func(src[i]))
			return i;
	}
	return -1;
}

int line_find_all(const int src[], int src_size, testfunc func,
				  int result[], int result_maxsize)
{
	find_count = 0; int count = 0;
	for (int i = 0; i < src_size && count < result_maxsize; i++)
	{
		find_count++;
		if (func(src[i]))
		{
			result[count] = i;
			count++;
		}
	}
	return count;
}

int bin_find_one(const int src[], int src_size, testfunc func)
{
	find_count = 0; int l = 0, r = src_size - 1;
	while (l <= r)
	{
		find_count++;
		int m = l + (r - l) / 2;
		int test = func(src[m]);
		if (!test)
			return m;
		else if (test < 0)
			l = m + 1;
		else
			r = m - 1;
	}
	return -1;
}

int bin_find_all(const int src[], int src_size, testfunc func,
				 int* res_beg, int* res_end)
{
	find_count = 0;
	int pos = bin_find_one(src, src_size, func);

	if (pos < 0)
		return 0;

	*res_beg = pos; *res_end = pos;
	while (*res_beg > 0 && !func(src[*res_beg - 1]))
	{
		find_count++; (*res_beg)--;
	}
	while (*res_end > 0 && !func(src[*res_end + 1]))
	{
		find_count++; (*res_end)++;
	}

	return *res_end - *res_beg + 1;
}


int test_equal(int value)
{
	return (value == 0) ? 0 : (value < 0 ? -1 : 1);
}

int test_equal_for_linear(int value)
{
	return (value == 0) ? 1 : 0;
}


int main(int argc, char** argv)
{
	int a[] = { 1, 2, 4, 5, 6, 25, 25, 25, 26, 40, 45, 60, 60, 65, 90, 90, 90 };
	int size = sizeof(a) / sizeof(a[0]);

	printf("line\n");
	int index = line_find_one(a, size, test_equal_for_linear);
	printf("%d %d\n\n", index, find_count);

	int lin = 1000; int results[lin];
	int count = line_find_all(a, size, test_equal_for_linear, results, lin);
	printf("длинна %d; %d\n", count, find_count);
	for (int i = 0; i < count; i++)
		printf("%d ", results[i]);
	printf("\n\n\nbin\n");
	
	index = bin_find_one(a, size, test_equal);
	printf("%d %d\n\n", index, find_count);
	
	if (index > -1)
	{
		int beg, end;
		count = bin_find_all(a, size, test_equal, &beg, &end);
		printf("длинна %d от %d до %d; %d\n\n", count, beg, end, find_count);
	}
}
