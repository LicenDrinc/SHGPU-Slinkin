#include "listunit_l1.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

pnodeL1 createNodeL1(char* str1)
{
	pnodeL1 TN1 = (pnodeL1)malloc(sizeof(tnodeL1));
	TN1->str = str1;
	TN1->TN = NULL;
	return TN1;
}

int listCountL1(pnodeL1 TN1)
{
	if (TN1 == NULL) return -1;
	
	pnodeL1 TNEnd = TN1;
	int i = 0;
	if (TN1 == NULL) return 0;
	for (;TNEnd->TN != NULL;i++)
		TNEnd = TNEnd->TN;
	return i + 1;
}

pnodeL1 addFirstNodeL1(pnodeL1 *TN1, pnodeL1 TN2)
{
	if (*TN1 == NULL) return (*TN1) = TN2;
	
	TN2->TN = *TN1;
	*TN1 = TN2;
	return TN2;
}

pnodeL1 addLastNodeL1(pnodeL1 *TN1, pnodeL1 TN2)
{
	if (*TN1 == NULL) return (*TN1) = TN2;
	
	pnodeL1 TNEnd = *TN1;
	for (;TNEnd->TN != NULL;)
		TNEnd = TNEnd->TN;
	TNEnd->TN = TN2;
	return TN2;
}

pnodeL1 insertAfterNodeL1(pnodeL1 *TN1, pnodeL1 TN2)
{
	if (*TN1 == NULL) return (*TN1) = TN2;
	
	TN2->TN = (*TN1)->TN;
	(*TN1)->TN = TN2;
	return TN2;
}

pnodeL1 addPosNodeL1(pnodeL1 *TN1, pnodeL1 TN2, int pos)
{
	if (*TN1 == NULL) return (*TN1) = TN2;
	if (pos >= listCountL1(*TN1)) return addLastNodeL1(TN1, TN2);
	if (pos <= 0) return addFirstNodeL1(TN1, TN2);
	
	pnodeL1 TNEnd = *TN1, TNEnd1 = *TN1;
	for (;pos != listCountL1(*TN1) - listCountL1(TNEnd);)
		TNEnd = (TNEnd1 = TNEnd)->TN;
	TNEnd1->TN = TN2;
	TN2->TN = TNEnd;
	return TN2;
}

pnodeL1 lastNodeL1(pnodeL1 TN1)
{
	if (TN1 == NULL) return NULL;
	
	pnodeL1 TNEnd = TN1;
	for (;TNEnd->TN == NULL;)
		TNEnd = TNEnd->TN;
	return TNEnd;
}

pnodeL1 posNodeL1(pnodeL1 TN1, int pos)
{
	if (TN1 == NULL) return NULL;
	if (pos >= listCountL1(TN1)) return NULL;
	
	pnodeL1 TNEnd = TN1;
	for (;pos != listCountL1(TN1) - listCountL1(TNEnd);)
		TNEnd = TNEnd->TN;
	return TNEnd;
}

void listOutL1(pnodeL1 TN1)
{
	if (TN1 == NULL) return;
	
	pnodeL1 TNEnd = TN1;
	for (;TNEnd != NULL;)
	{
		printf("%s\n",TNEnd->str);
		TNEnd = TNEnd->TN;
	}
}

void disposeNodeL1(pnodeL1 *TN1)
{
	if (*TN1 == NULL) return;
	
	free(*TN1);
	*TN1 = NULL;
}

void disposeListL1(pnodeL1 *TN1)
{
	if (*TN1 == NULL) return;
	
	pnodeL1 TNEnd = *TN1, TNEnd1 = *TN1;
	for (;TNEnd != NULL;)
	{
		TNEnd = (TNEnd1 = TNEnd)->TN;
		free(TNEnd1);
	}
	*TN1 = NULL;
}

void disposeFristNodeL1(pnodeL1 *TN1)
{
	if (*TN1 == NULL) return;
	
	pnodeL1 TNEnd = *TN1;
	*TN1 = (*TN1)->TN;
	free(TNEnd);
}

void disposeLastNodeL1(pnodeL1 *TN1)
{
	if (*TN1 == NULL) return;
	
	pnodeL1 TNEnd = *TN1, TNEnd1 = *TN1;
	for (;(*TNEnd).TN != NULL;)
		TNEnd = (TNEnd1 = TNEnd)->TN;
	free(TNEnd);
	TNEnd1->TN = NULL;
}

void disposePosNodeL1(pnodeL1 *TN1, int pos)
{
	if (*TN1 == NULL) return;
	if (pos >= listCountL1(*TN1)) return;
	if (pos <= 0) disposeFristNodeL1(TN1);
	else
	{
		pnodeL1 TNEnd = *TN1, TNEnd1 = *TN1, TNEnd2 = *TN1;
		for (;pos != listCountL1(*TN1) - listCountL1(TNEnd);)
			TNEnd = (TNEnd1 = TNEnd)->TN;
		TNEnd2 = TNEnd->TN;
		free(TNEnd);
		TNEnd1->TN = TNEnd2;
	}
}

void disposeAfterNodeL1(pnodeL1 TN1)
{
	if (TN1 == NULL) return;
	if (TN1->TN == NULL) return;
	
	pnodeL1 TNEnd = TN1->TN->TN;
	free(TN1->TN);
	TN1->TN = TNEnd;
}

pnodeL1 deleteFirstNodeL1(pnodeL1 *TN1)
{
	if (TN1 == NULL) return NULL;
	
	pnodeL1 TNEnd = *TN1;
	*TN1 = (*TN1)->TN;
	TNEnd->TN = NULL;
	return TNEnd;
}

pnodeL1 deleteLastNodeL1(pnodeL1 *TN1)
{
	if (TN1 == NULL) return NULL;
	
	pnodeL1 TNEnd = *TN1, TNEnd1 = *TN1;
	for (;TNEnd->TN != NULL;)
		TNEnd = (TNEnd1 = TNEnd)->TN;
	TNEnd1->TN = NULL;
	TNEnd->TN = NULL;
	return TNEnd; 
}

pnodeL1 deletePosNodeL1(pnodeL1 *TN1, int pos)
{
	if (TN1 == NULL) return NULL;
	if (pos >= listCountL1(*TN1)) return NULL;
	if (pos <= 0) return deleteFirstNodeL1(TN1);
	else
	{
		pnodeL1 TNEnd = *TN1, TNEnd1 = *TN1, TNEnd2 = *TN1;
		for (;pos != listCountL1(*TN1) - listCountL1(TNEnd);)
			TNEnd = (TNEnd1 = TNEnd)->TN;
		TNEnd2 = TNEnd->TN;
		TNEnd1->TN = TNEnd2;
		TNEnd->TN = NULL;
		return TNEnd;
	}
}

pnodeL1 deleteAfterNodeL1(pnodeL1 TN1)
{
	if (TN1 == NULL) return NULL;
	if (TN1->TN == NULL) return NULL;
	
	pnodeL1 TNEnd = TN1->TN;
	TN1->TN = TN1->TN->TN;
	TNEnd->TN = NULL;
	return TNEnd;
}

void listActionL1(pnodeL1 *TN1, listfunc func)
{
	if (TN1 == NULL) return;
	
	pnodeL1 TNEnd = *TN1;
	for (;TNEnd != NULL;)
	{
		if (func(TNEnd->str) == 0) return;
		TNEnd = TNEnd->TN;
	}
}

char* listSumStr(pnodeL1 TN1, char *dest, int maxsize, char *delimiter)
{
	dest[0] = '\0';
	if (maxsize == 0) return "NULL";
	if (TN1 == NULL) return "NULL";
	
	int linSize = 0; pnodeL1 TNEnd = TN1;
	for (;TNEnd != NULL && linSize < maxsize;)
	{
		if (linSize < maxsize)
		{ strncat(dest, TNEnd->str, maxsize - linSize); linSize += strlen((*TNEnd).str); }
		if (linSize < maxsize)
		{ strncat(dest, delimiter, maxsize - linSize); linSize += strlen(delimiter); }
		TNEnd = TNEnd->TN;
	}
	return dest;
}
