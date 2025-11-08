#ifndef SQUNITL
#define SQUNITL

typedef struct LStack* pLStack;
typedef struct LStack {
	int data;
	pLStack next;
} LStack;

pLStack LStack_create(int maxsize);
void LStack_destroy(pLStack* stack);
void LStack_push(pLStack stack, int number);
int LStack_pop(pLStack stack);
int LStack_empty(pLStack stack);
int LStack_full(pLStack stack);
int LStack_count(pLStack stack);

typedef struct LQueue* pLQueue;
typedef struct LQueue {
	int data;
	pLQueue next;
	pLQueue prev;
} LQueue;

pLQueue LQueue_create(int maxsize);
void LQueue_destroy(pLQueue* que);
void LQueue_put(pLQueue que, int number);
int LQueue_get(pLQueue que);
int LQueue_empty(pLQueue que);
int LQueue_full(pLQueue que);
int LQueue_count(pLQueue que);

#endif

