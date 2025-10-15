#ifndef LISTUNIT_L1
#define LISTUNIT_L1

typedef struct tnodeL1 {
	char* str;
	struct tnodeL1* TN;
} tnodeL1;
typedef struct tnodeL1* pnodeL1;

typedef int (*listfunc)(char*);

pnodeL1 createNodeL1(char* str1);
int listCountL1(pnodeL1 TN1);

pnodeL1 addFirstNodeL1(pnodeL1 *TN1, pnodeL1 TN2);
pnodeL1 addLastNodeL1(pnodeL1 *TN1, pnodeL1 TN2);
pnodeL1 insertAfterNodeL1(pnodeL1 *TN1, pnodeL1 TN2);
pnodeL1 addPosNodeL1(pnodeL1 *TN1, pnodeL1 TN2, int pos);

pnodeL1 lastNodeL1(pnodeL1 TN1);
pnodeL1 posNodeL1(pnodeL1 TN1, int pos);

void listOutL1(pnodeL1 TN1);

void disposeNodeL1(pnodeL1 *TN1);
void disposeListL1(pnodeL1 *TN1);
void disposeFristNodeL1(pnodeL1 *TN1);
void disposeLastNodeL1(pnodeL1 *TN1);
void disposeAfterNodeL1(pnodeL1 TN1);
void disposePosNodeL1(pnodeL1 *TN1, int pos);

pnodeL1 deleteFirstNodeL1(pnodeL1 *TN1);
pnodeL1 deleteLastNodeL1(pnodeL1 *TN1);
pnodeL1 deleteAfterNodeL1(pnodeL1 TN1);
pnodeL1 deletePosNodeL1(pnodeL1 *TN1, int pos);

void listActionL1(pnodeL1 *TN1, listfunc func);

char* listSumStr(pnodeL1 TN1, char *dest, int maxsize, char *delimiter);

#endif
