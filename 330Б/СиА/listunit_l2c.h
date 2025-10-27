#ifndef LISTUNIT_L2C
#define LISTUNIT_L2C

typedef struct tnodeL2C {
	double data;
	pnodeL2C prev, next;
} tnodeL2C;
typedef struct tnodeL2C* pnodeL2C;

typedef int (*listfunc)(double);

 pnodeL2C createNodeL2C(double data);
 int listCountL2C(pnodeL2C ph);
 
pnodeL2C addFirstNodeL2C(pnodeL2C *ph, pnodeL2C p);
pnodeL2C addLastNodeL2C(pnodeL2C *ph, pnodeL2C p);
pnodeL2C insertAfterNodeL2C(pnodeL2C pn, pnodeL2C p);
pnodeL2C insertBeforeNodeL2C(pnodeL2C pn, pnodeL2C p);

pnodeL2C deleteNodeL2C(pnodeL2C *ph, pnodeL2C pn);
void disposeNodeL2C(pnodeL2C *pn);
void disposeListL2C(pnodeL2C *ph);

void listActionL2C(pnodeL2C ph, int fwd, listfunc func);

void listOutL2C(pnodeL2C ph, int fwd);
double minmaxL2C(pnodeL2C ph, int min);
pnodeL2C abNodeL2C(pnodeL2C ph, int first, int above, double data);

#endif

