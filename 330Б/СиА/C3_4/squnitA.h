#ifndef SQUNITA
#define SQUNITA

typedef struct AStack *pAStack;
typedef struct AStack {   
	int *data;
	int maxsize;
	int count;
} AStack;

pAStack AStack_create(int maxsize);
void AStack_destroy(pAStack* stack);
void AStack_push(pAStack stack, int number);
int AStack_pop(pAStack stack);
int AStack_empty(pAStack stack);
int AStack_full(pAStack stack);
int AStack_count(pAStack stack);

typedef struct AQueue *pAQueue;
typedef struct AQueue {
	int *data;
	int maxsize;
	int first,last;
} AQueue;

pAQueue AQueue_create(int maxsize);
void AQueue_destroy(pAQueue* que);
void AQueue_put(pAQueue que, int number);
int AQueue_get(pAQueue que);
int AQueue_empty(pAQueue que);
int AQueue_full(pAQueue que);
int AQueue_count(pAQueue que);

#endif

