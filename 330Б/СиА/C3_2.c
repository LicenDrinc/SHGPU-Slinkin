#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TNode {
	char* str;
	struct TNode* TN;
} TNode;
typedef struct TNode* PNode;

PNode createTN(char* str1)
{
	PNode TN1 = (PNode)malloc(sizeof(TNode));
	(*TN1).str = str1; return TN1;
}

int linTN(PNode TN1)
{
	PNode TNEnd = TN1; int i = 0;
	if (TN1 == NULL) return 0;
	for (;(*TNEnd).TN != NULL;i++)
		TNEnd = (*TNEnd).TN;
	return i + 1;
}

PNode plusHomeTN(PNode *TN1, PNode TN2)
{
	(*TN2).TN = *TN1; *TN1 = TN2; return TN2;
}

PNode plusEndTN(PNode *TN1, PNode TN2)
{
	PNode TNEnd = *TN1;
	for (;(*TNEnd).TN != NULL;)
		TNEnd = (*TNEnd).TN;
	(*TNEnd).TN = TN2; return TN2;
}

PNode plusInsAftTN(PNode *TN1, PNode TN2, int pos)
{
	if (pos >= linTN(*TN1)) return plusEndTN(TN1, TN2);
	if (0 >= linTN(*TN1)) return plusHomeTN(TN1, TN2);
	PNode TNEnd = *TN1, TNEnd1 = *TN1;
	for (;pos != linTN(*TN1) - linTN(TNEnd);)
		TNEnd = (*(TNEnd1 = TNEnd)).TN;
	(*TNEnd1).TN = TN2; (*TN2).TN = TNEnd;
	return TN2;
}

PNode homeTN(PNode TN1)
{
	PNode TNEnd = TN1; return TNEnd;
}

PNode endTN(PNode TN1)
{
	PNode TNEnd = TN1;
	for (;(*TNEnd).TN == NULL;)
		TNEnd = (*TNEnd).TN;
	return TNEnd;
}

PNode insAftTN(PNode TN1, int pos)
{
	PNode TNEnd = TN1;
	for (;pos != linTN(TN1) - linTN(TNEnd);)
		TNEnd = (*TNEnd).TN;
	return TNEnd;
}

void printTN(PNode TN1)
{
	PNode TNEnd = TN1;
	if (TN1 == NULL) return;
	for (;(*TNEnd).TN != NULL;)
	{
		printf("%s\n",(*TNEnd).str);
		TNEnd = (*TNEnd).TN;
	}
	printf("%s\n",(*TNEnd).str);
}

void destroyTN(PNode *TN1)
{
	for (;linTN(*TN1) != 1;)
	{
		PNode TNEnd = *TN1, TNEnd1 = *TN1;
		for (;(*TNEnd).TN != NULL;)
			TNEnd = (*(TNEnd1 = TNEnd)).TN;
		free(TNEnd); (*TNEnd1).TN = NULL;
	}
	free(*TN1); *TN1 = NULL;
}

void destroyElemHomeTN(PNode *TN1)
{
	PNode TNEnd = *TN1;
	*TN1 = (**TN1).TN; free(TNEnd);
}

void destroyElemEndTN(PNode *TN1)
{
	PNode TNEnd = *TN1, TNEnd1 = *TN1;
	for (;(*TNEnd).TN != NULL;)
		TNEnd = (*(TNEnd1 = TNEnd)).TN;
	free(TNEnd); (*TNEnd1).TN = NULL;
}

void destroyElemTN(PNode *TN1, int pos)
{
	if (pos < linTN(*TN1))
	{
		if (pos <= 0) destroyElemHomeTN(TN1);
		else
		{
			PNode TNEnd = *TN1, TNEnd1 = *TN1, TNEnd2 = *TN1;
			for (;pos != linTN(*TN1) - linTN(TNEnd);)
				TNEnd = (*(TNEnd1 = TNEnd)).TN;
			TNEnd2 = (*TNEnd).TN;
			free(TNEnd); (*TNEnd1).TN = TNEnd2;
		}
	}
}

PNode shutdownElemTN(PNode *TN1, int pos)
{
	if (pos < linTN(*TN1))
	{
		PNode TNEnd = *TN1, TNEnd1 = *TN1, TNEnd2 = *TN1;
		if (pos <= 0)
		{
			TNEnd1 = (**TN1).TN; *TN1 = TNEnd1;
		}
		else
		{
			for (;pos != linTN(*TN1) - linTN(TNEnd);)
				TNEnd = (*(TNEnd1 = TNEnd)).TN;
			TNEnd2 = (*TNEnd).TN; (*TNEnd1).TN = TNEnd2;
		}
		(*TNEnd).TN = NULL; return TNEnd;
	}
	return NULL;
}

char* strTN(PNode TN1, char *dest, int maxsize, char *delimiter)
{
	if (maxsize == 0) return "NULL";
	if (TN1 == NULL) return "NULL";
	dest = (char*)malloc(maxsize * sizeof(char));
	int linSize = 0; PNode TNEnd = TN1;
	for (;(*TNEnd).TN != NULL && linSize < maxsize;)
	{
		for (int i = 0; i < strlen((*TNEnd).str) && linSize < maxsize; i++, linSize++)
			dest[linSize] = (*TNEnd).str[i];
		for (int i = 0; i < strlen(delimiter) && linSize < maxsize; i++, linSize++)
			dest[linSize] = delimiter[i];
		TNEnd = (*TNEnd).TN;
	}
	for (int i = 0; i < strlen((*TNEnd).str) && linSize < maxsize; i++, linSize++)
		dest[linSize] = (*TNEnd).str[i];
	return dest;
}

int main(int argc, char **argv)
{
	PNode TN = createTN("wretete");
	plusEndTN(&TN, createTN("10244"));
	plusHomeTN(&TN, createTN("1024411"));
	plusHomeTN(&TN, createTN("102"));
	plusHomeTN(&TN, createTN("102555"));
	printTN(TN); printf("\n");
	plusInsAftTN(&TN, createTN("1"), 2);
	printTN(TN); printf("\n");
	char* l = "";
	printf("%s\n",strTN(TN, l, 50, " | "));
	destroyElemEndTN(&TN);
	printf("%s\n",strTN(TN, l, 50, " | "));
	destroyElemHomeTN(&TN);
	printf("%s\n",strTN(TN, l, 50, " | "));
	destroyElemTN(&TN, 1);
	printf("%s\n",strTN(TN, l, 50, " | "));
	printf("%s\n",strTN(shutdownElemTN(&TN, 1), l, 50, " | "));
	printf("%s\n",strTN(TN, l, 50, " | "));
	destroyTN(&TN);
	printf("%s\n",strTN(TN, l, 50, " | "));
}
