#include "squnitA.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

pAStack AStack_create(int maxsize)
{
	pAStack r = (pAStack)malloc(sizeof(AStack));
	r->data = (int*)malloc(maxsize * sizeof(int));
	r->maxsize = maxsize; r->count = 0;
	return r;
}
void AStack_destroy(pAStack* stack)
{
	if (*stack == NULL) return;
	free((*stack)->data);
	free(*stack);
	*stack = NULL;
}
void AStack_push(pAStack stack, int number)
{
	if (stack == NULL) return;
	if (stack->maxsize <= stack->count) return;
	stack->data[stack->count] = number;
	stack->count++;
}
int AStack_pop(pAStack stack)
{
	if (stack == NULL) return 0;
	if (stack->count <= 0) return 0;
	int i = stack->count; stack->count--;
	return stack->data[i-1];
}
int AStack_empty(pAStack stack)
{
	if (stack == NULL) return -1;
	return stack->count <= 0;
}
int AStack_full(pAStack stack)
{
	if (stack == NULL) return -1;
	return stack->maxsize <= stack->count;
}
int AStack_count(pAStack stack)
{
	if (stack == NULL) return -1;
	return stack->count;
}



pAQueue AQueue_create(int maxsize)
{
	pAQueue r = (pAQueue)malloc(sizeof(AQueue));
	r->data = (int*)malloc(maxsize * sizeof(int));
	r->maxsize = maxsize; r->first = r->last = -1;
	return r;
}
void AQueue_destroy(pAQueue* que)
{
	if (*que == NULL) return;
	free((*que)->data);
	free(*que);
	*que = NULL;
}
void AQueue_put(pAQueue que, int number)
{
	if (que == NULL) return;
	if (que->last == -1) que->last = que->first = 0;
	else
	{
		int last = que->last + 1 >= que->maxsize ? 0 : que->last + 1;
		if (last == que->first) return;
		que->last = last;
	}
	que->data[que->last] = number;
}
int AQueue_get(pAQueue que)
{
	if (que == NULL) return 0;
	if (que->first == -1) return 0;
	int f;
	if (que->first == que->last)
	{
		f = que->first; que->first = que->last = -1;
	}
	else
	{
		f = que->first;
		que->first = que->first + 1 >= que->maxsize ? 0 : que->first + 1;
	}
	return que->data[f];
}
int AQueue_empty(pAQueue que)
{
	if (que == NULL) return -1;
	return que->last == -1;
}
int AQueue_full(pAQueue que)
{
	if (que == NULL) return -1;
	return (que->last + 1 >= que->maxsize ? 0 : que->last + 1) == que->first;
}
int AQueue_count(pAQueue que)
{
	if (que == NULL) return -1;
	if (que->first == -1) return 0;
	if (que->first > que->last) return que->last + 1 + que->maxsize - que->first;
	return que->last - que->first + 1;
}


