#ifndef treeunit
#define treeunit

typedef struct NTree* PTree;
typedef struct NTree {
	int data;
	PTree left, right;
} NTree;

PTree createNTree(int number);

void pushNTree(PTree* HPTree, PTree NTree);
PTree pullNTree(PTree* HPTree, int number);

void destroyNTree(PTree* HPTree);

void printNTree(PTree HTRee, int mode);
void printAltNTree(PTree HTRee, int mode);
PTree findNTree(PTree HTRee, int number);

int deepthNTree(PTree HTRee, PTree NTree);
int maxDeepthNTree(PTree HTRee);
int countNTree(PTree HTRee);
int balancedNTree(PTree HTRee);

#endif

