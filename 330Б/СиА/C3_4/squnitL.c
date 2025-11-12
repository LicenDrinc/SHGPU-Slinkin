#include "squnitL.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

pLStack LStack_create(int maxsize)
{
	pLStack r = (pLStack)malloc(sizeof(LStack));
	r->data = 0; r->next = NULL;
	return r;
}
void LStack_destroy(pLStack* stack)
{
	if (*stack == NULL) return;
	pLStack r = (*stack)->next, r1 = (*stack)->next;
	for (; r != NULL;)
	{
		r1 = r->next;
		free(r); r = r1;
	}
	free(*stack);
	*stack = NULL;
}
void LStack_push(pLStack stack, int number)
{
	if (stack == NULL) return;
	pLStack r = (pLStack)malloc(sizeof(LStack)), r1 = stack->next;
	r->data = number; r->next = NULL;
	if (r1 == NULL) stack->next = r;
	else
	{
		for (; r1->next != NULL;) r1 = r1->next;
		r1->next = r;
	}
	stack->data++;
}
int LStack_pop(pLStack stack)
{
	if (stack == NULL) return 0;
	if (stack->data == 0) return 0;
	pLStack r = stack->next, r1 = stack->next;
	for (; r1->next != NULL;) { r = r1; r1 = r->next; }
	int i = r1->data; r->next = NULL; free(r1);
	stack->data--;
	if (stack->data == 0) stack->next = NULL;
	return i;
}
int LStack_empty(pLStack stack)
{
	if (stack == NULL) return -1;
	return stack->data == 0;
}
int LStack_full(pLStack stack)
{
	if (stack == NULL) return -1;
	return 0;
}
int LStack_count(pLStack stack)
{
	if (stack == NULL) return -1;
	return stack->data;
}



pLQueue LQueue_create(int maxsize)
{
	pLQueue r = (pLQueue)malloc(sizeof(LQueue));
	r->data = 0; r->next = r->prev = NULL;
	return r;
}
void LQueue_destroy(pLQueue* que)
{
	if (*que == NULL) return;
	pLQueue r = (*que)->next, r1 = (*que)->next;
	if (r != NULL) r->prev->next = NULL;
	for (; r != NULL;)
	{
		r1 = r->next;
		free(r); r = r1;
	}
	free(*que);
	*que = NULL;
}
void LQueue_put(pLQueue que, int number)
{
	if (que == NULL) return;
	pLQueue r = (pLQueue)malloc(sizeof(LQueue)), r1 = que->next;
	r->data = number; r->next = r->prev = r;
	if (r1 == NULL) que->next = r;
	else
	{
		r->next = r1; r->prev = r1->prev;
		r1->prev->next = r;
		r1->prev = r;
	}
	que->data++;
}
int LQueue_get(pLQueue que)
{
	if (que == NULL) return 0;
	if (que->data == 0) return 0;
	pLQueue r = que->next, r1 = que->next;
	que->next = r->next; que->data--;
	int i = r1->data;
	if (que->data == 0) que->next = NULL;
	else
	{
		r->next->prev = r->prev;
		r->prev->next = r->next;
	}
	free(r1);
	return i;
}
int LQueue_empty(pLQueue que)
{
	if (que == NULL) return -1;
	return que->data == 0;
}
int LQueue_full(pLQueue que)
{
	if (que == NULL) return -1;
	return 0;
}
int LQueue_count(pLQueue que)
{
	if (que == NULL) return -1;
	return que->data;
}

