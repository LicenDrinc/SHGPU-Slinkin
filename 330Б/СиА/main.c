#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "listunit_l1.h"

int printTo(char* s)
{
	if (strlen(s) < 2) return 0;
	printf("|%s| ",s);
	return 1;
}

int main()
{
	pnodeL1 TN = createNodeL1("10ф15");
	//pnodeL1 TN1;
	//insertAfterNodeL1(&TN, createNodeL1("3-"));
	//addPosNodeL1(&TN, createNodeL1("-3"), 1);
	
	//addFirstNodeL1(&TN, createNodeL1("-1"));
	//addLastNodeL1(&TN, createNodeL1("1-"));
	//printf("lin = %d\n",listCountL1(TN)); listOutL1(TN); printf("\n");
	disposeListL1(&TN);
	/*
	addLastNodeL1(&TN, createNodeL1("-2"));
	addFirstNodeL1(&TN, createNodeL1("2-"));
	printf("lin = %d | ",listCountL1(TN));
	char* l = ""; printf("%s\n", listSumStr(TN, l, 50, " | ")); printf("\n");
	
	addPosNodeL1(&TN, createNodeL1("-3"), 1);
	TN1 = posNodeL1(TN, 4);
	insertAfterNodeL1(&TN1, createNodeL1("3-"));
	printf("lin = %d | ",listCountL1(TN));
	printf("%s\n", listSumStr(TN, l, 50, " | ")); printf("\n");
	
	listActionL1(&TN, &printTo); printf("\n");
	TN1 = posNodeL1(TN, 3);
	insertAfterNodeL1(&TN1, createNodeL1("0"));
	listActionL1(&TN, &printTo); printf("\n\n");
	
	disposePosNodeL1(&TN, 1);
	disposeAfterNodeL1(posNodeL1(TN, 2));
	disposeAfterNodeL1(posNodeL1(TN, 3));
	printf("{lin = %d} ",listCountL1(TN));
	printf("%s\n", listSumStr(TN, l, 50, " | ")); printf("\n");
	
	disposeLastNodeL1(&TN);
	disposeFristNodeL1(&TN);
	printf("{lin = %d} ",listCountL1(TN));
	printf("%s\n", listSumStr(TN, l, 50, " | ")); printf("\n");
	
	addLastNodeL1(&TN, createNodeL1("-2"));
	addFirstNodeL1(&TN, createNodeL1("2-"));
	printf("{lin = %d} ",listCountL1(TN));
	printf("%s\n", listSumStr(TN, l, 50, " | ")); printf("\n");
	
	listOutL1(deletePosNodeL1(&TN, 1));
	listOutL1(deleteAfterNodeL1(posNodeL1(TN, 1))); printf("\n");
	printf("{lin = %d} ",listCountL1(TN));
	printf("%s\n", listSumStr(TN, l, 50, " | ")); printf("\n");
	
	listOutL1(deleteFirstNodeL1(&TN));
	listOutL1(deleteLastNodeL1(&TN)); printf("\n");
	printf("{lin = %d} ",listCountL1(TN));
	printf("%s\n", listSumStr(TN, l, 50, " | ")); printf("\n");
	
	addFirstNodeL1(&TN, createNodeL1("-1"));
	addLastNodeL1(&TN, createNodeL1("1-"));
	disposeListL1(&TN);
	printf("lin = %d dest\n",listCountL1(TN)); listOutL1(TN); printf("\n");
	printf("%s\n", listSumStr(TN, l, 50, " | ")); printf("\n");
	/**/
	 
	return 0;
}
