#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "squnitA.h"
#include "squnitL.h"

int main()
{
	printf("----------------------A\n");

	pAStack A = AStack_create(5);
	AStack_push(A, 1);
	AStack_push(A, 2);
	AStack_push(A, 3);
	AStack_push(A, 4);
	AStack_push(A, 5);
	for (int i = 0; i < A->count; i++) printf("%d ",A->data[i]);
	printf("\n");
	printf("%d %d %d\n---\n", AStack_empty(A), AStack_full(A), AStack_count(A));
	AStack_pop(A);
	AStack_pop(A);
	for (int i = 0; i < A->count; i++) printf("%d ", A->data[i]);
	printf("\n");
	printf("%d %d %d\n---\n", AStack_empty(A), AStack_full(A), AStack_count(A));
	printf("%d ", AStack_pop(A));
	printf("%d ", AStack_pop(A));
	printf("%d ", AStack_pop(A));
	printf("%d\n", AStack_pop(A));
	printf("%d %d %d\n---\n", AStack_empty(A), AStack_full(A), AStack_count(A));
	AStack_push(A, 1);
	AStack_destroy(&A);
	printf("%d %d %d\n", AStack_empty(A), AStack_full(A), AStack_count(A));

	printf("----------------------Q\n");

	pAQueue Q = AQueue_create(5);
	AQueue_put(Q, 1);
	AQueue_put(Q, 2);
	AQueue_put(Q, 3);
	AQueue_put(Q, 4);
	AQueue_put(Q, 5);
	for (int i = 0; i < Q->maxsize; i++) printf("%d ", Q->data[i]);
	printf("\n");
	printf("%d %d %d\n---\n", AQueue_empty(Q), AQueue_full(Q), AQueue_count(Q));
	AQueue_get(Q);
	AQueue_get(Q);
	AQueue_put(Q, 6);
	AQueue_put(Q, 7);
	for (int i = 0; i < Q->maxsize; i++) printf("%d ", Q->data[i]);
	printf("\n");
	printf("%d %d %d\n---\n", AQueue_empty(Q), AQueue_full(Q), AQueue_count(Q));
	printf("%d ", AQueue_get(Q));
	printf("%d ", AQueue_get(Q));
	printf("%d ", AQueue_get(Q));
	printf("%d ", AQueue_get(Q));
	printf("%d\n", AQueue_get(Q));
	printf("%d %d %d\n---\n", AQueue_empty(Q), AQueue_full(Q), AQueue_count(Q));
	AQueue_put(Q, 1);
	AQueue_destroy(&Q);
	printf("%d %d %d\n", AQueue_empty(Q), AQueue_full(Q), AQueue_count(Q));

	printf("----------------------L\n");

	pLStack L = LStack_create(5);
	LStack_push(L, 1);
	LStack_push(L, 2);
	LStack_push(L, 3);
	LStack_push(L, 4);
	LStack_push(L, 5);
	pLStack L1 = L->next;
	for (int i = 0; i < L->data; i++) { printf("%d ", L1->data); L1 = L1->next; }
	printf("\n");
	printf("%d %d %d\n---\n", LStack_empty(L), LStack_full(L), LStack_count(L));
	LStack_pop(L);
	LStack_pop(L);
	L1 = L->next;
	for (int i = 0; i < L->data; i++) { printf("%d ", L1->data); L1 = L1->next; }
	printf("\n");
	printf("%d %d %d\n---\n", LStack_empty(L), LStack_full(L), LStack_count(L));
	printf("%d ", LStack_pop(L));
	printf("%d ", LStack_pop(L));
	printf("%d ", LStack_pop(L));
	printf("%d\n", LStack_pop(L));
	printf("%d %d %d\n---\n", LStack_empty(L), LStack_full(L), LStack_count(L));
	LStack_push(L, 1);
	LStack_destroy(&L);
	printf("%d %d %d\n", LStack_empty(L), LStack_full(L), LStack_count(L));
	
	printf("----------------------R\n");

	pLQueue R = LQueue_create(5);
	LQueue_put(R, 1);
	LQueue_put(R, 2);
	LQueue_put(R, 3);
	LQueue_put(R, 4);
	LQueue_put(R, 5);
	pLQueue R1 = R->next;
	for (int i = 0; i < R->data; i++) { printf("%d ", R1->data); R1 = R1->next; }
	printf("\n");
	printf("%d %d %d\n---\n", LQueue_empty(R), LQueue_full(R), LQueue_count(R));
	LQueue_get(R);
	LQueue_get(R);
	LQueue_put(R, 6);
	LQueue_put(R, 7); 
	R1 = R->next;
	for (int i = 0; i < R->data; i++) { printf("%d ", R1->data); R1 = R1->next; }
	printf("\n");
	printf("%d %d %d\n---\n", LQueue_empty(R), LQueue_full(R), LQueue_count(R));
	printf("%d ", LQueue_get(R));
	printf("%d ", LQueue_get(R));
	printf("%d ", LQueue_get(R));
	printf("%d ", LQueue_get(R));
	printf("%d\n", LQueue_get(R));
	printf("%d %d %d\n---\n", LQueue_empty(R), LQueue_full(R), LQueue_count(R));
	LQueue_put(R, 1);
	LQueue_destroy(&R);
	printf("%d %d %d\n", LQueue_empty(R), LQueue_full(R), LQueue_count(R));
}
