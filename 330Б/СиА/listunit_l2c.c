#include "listunit_l2c.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

pnodeL2C createNodeL2C(double data)
{
	pnodeL2C TN = (pnodeL2C)malloc(sizeof(tnodeL2C));
	TN->data = data; TN->prev = TN->next = TN;
	return TN;
}

int listCountL2C(pnodeL2C ph)
{
	if (ph == NULL) return 0;

	pnodeL2C phe = ph;
	int i = 0;
	for (; phe->next != ph; i++)
		phe = phe->next;
	return i + 1;
}

pnodeL2C addFirstNodeL2C(pnodeL2C* ph, pnodeL2C p)
{
	if (p == NULL) return NULL;
	if (*ph == NULL) return *ph = p;

	p->next = *ph;
	p->prev = (*ph)->prev;
	(*ph)->prev->next = p;
	(*ph)->prev = p;
	return *ph = p;
}
pnodeL2C addLastNodeL2C(pnodeL2C* ph, pnodeL2C p)
{
	if (p == NULL) return NULL;
	if (*ph == NULL) return *ph = p;

	p->next = *ph;
	p->prev = (*ph)->prev;
	(*ph)->prev->next = p;
	(*ph)->prev = p;
	return p;
}
pnodeL2C insertAfterNodeL2C(pnodeL2C pn, pnodeL2C p)
{
	if (pn == NULL || p == NULL) return NULL;

	p->next = pn->next;
	p->prev = pn;
	pn->next->prev = p;
	pn->next = p;
	return p;
}
pnodeL2C insertBeforeNodeL2C(pnodeL2C pn, pnodeL2C p)
{
	if (pn == NULL || p == NULL) return NULL;

	p->prev = pn->prev;
	p->next = pn;
	pn->prev->next = p;
	pn->prev = p;
	return p;
}

pnodeL2C deleteNodeL2C(pnodeL2C* ph, pnodeL2C pn)
{
	if (*ph == NULL || pn == NULL) return NULL;

	pnodeL2C tn1 = *ph;
	for (; tn1->next != *ph && tn1 != pn; ) tn1 = tn1->next;
	if (tn1->next == *ph) return NULL;
	if (*ph == pn) *ph = tn1->next;
	tn1->prev->next = tn1->next;
	tn1->next->prev = tn1->prev;
	pn->next = pn->prev = pn;
	return pn;
}
void disposeNodeL2C(pnodeL2C* pn)
{
	if (*pn == NULL) return;
	free(*pn);
	*pn = NULL;
}
void disposeListL2C(pnodeL2C* ph)
{
	if (*ph == NULL) return;

	pnodeL2C tn1 = *ph;
	for (; tn1->next != *ph;)
	{
		tn1 = tn1->next;
		free(tn1->prev);
	}
	free(tn1);
	*ph = NULL;
}

void listActionL2C(pnodeL2C ph, int fwd, listfunc1 func)
{
	if (ph == NULL || func == NULL) return;

	pnodeL2C tn1 = (!fwd ? ph->prev : ph);
	for (int i = 0; (!fwd ? tn1->next : tn1) != ph || i == 0; i++)
	{
		if (!func(tn1->data)) return;
		tn1 = (!fwd ? tn1->prev : tn1->next);
	}
}

int printAll(double d)
{
	printf("%lf ", d);
	return 1;
}
void listOutL2C(pnodeL2C ph, int fwd)
{
	if (ph == NULL) return;

	listActionL2C(ph, fwd, printAll);
	printf("\n");
}
double minmaxL2C(pnodeL2C ph, int min)
{
	if (ph == NULL) return 0;

	double minmax = (!min ? LLONG_MIN : LLONG_MAX);
	pnodeL2C tn1 = ph;
	for (int i = 0; tn1 != ph || i == 0; i++)
	{
		minmax = ((!min && minmax < tn1->data) || (min && minmax > tn1->data) ? tn1->data : minmax);
		tn1 = tn1->next;
	}
	return minmax;
}
pnodeL2C abNodeL2C(pnodeL2C ph, int first, int above, double data)
{
	if (ph == NULL) return NULL;

	pnodeL2C tn1 = (!first ? ph->prev : ph);
	for (int i = 0; (!first ? tn1->next : tn1) != ph || i == 0; i++)
	{
		if ((above && data < tn1->data) || (!above && data > tn1->data)) return tn1;
		tn1 = (!first ? tn1->prev : tn1->next);
	}
	return NULL;
}