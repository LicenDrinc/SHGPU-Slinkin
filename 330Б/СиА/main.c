#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "listunit_l1.h"
#include "listunit_l2c.h"

int printTo(double d)
{
	if (d < 15) return 0;
	printf("|%lf| ",d);
	return 1;
}

int main()
{
	pnodeL2C tn, tn1;
	addFirstNodeL2C(&tn, createNodeL2C(40));
	listOutL2C(tn, 1);
	printf("%d\n", listCountL2C(tn));

	tn1 = addLastNodeL2C(&tn, createNodeL2C(30));
	listOutL2C(tn, 1);
	printf("%d\n", listCountL2C(tn));
	
	insertAfterNodeL2C(tn, createNodeL2C(20));
	listOutL2C(tn, 1);
	printf("%d\n", listCountL2C(tn));
	
	insertBeforeNodeL2C(tn1, createNodeL2C(10));
	listOutL2C(tn, 1);
	printf("%d\n", listCountL2C(tn));

	printf("%lf %lf\n\n", minmaxL2C(tn, 0), minmaxL2C(tn, 1));

	printf("%lf %lf\n", abNodeL2C(tn, 0, 0, 25)->data, abNodeL2C(tn, 0, 0, 35)->data);
	printf("%lf %lf\n", abNodeL2C(tn, 0, 1, 15)->data, abNodeL2C(tn, 0, 1, 35)->data);
	printf("%lf %lf\n", abNodeL2C(tn, 1, 0, 25)->data, abNodeL2C(tn, 1, 0, 45)->data);
	printf("%lf %lf\n", abNodeL2C(tn, 1, 1, 5)->data, abNodeL2C(tn, 1, 1, 35)->data);

	printf("\n"); listOutL2C(tn, 0);

	listActionL2C(tn, 1, &printTo); printf("\n");
	listActionL2C(tn, 0, &printTo); printf("\n");

	tn1 = deleteNodeL2C(&tn, abNodeL2C(tn, 1, 1, 35));
	disposeListL2C(&tn1); listOutL2C(tn, 1);

	tn1 = deleteNodeL2C(&tn, abNodeL2C(tn, 1, 0, 15));
	disposeListL2C(&tn1); listOutL2C(tn, 1); 
	
	tn1 = deleteNodeL2C(&tn, tn);
	disposeListL2C(&tn1); listOutL2C(tn, 1);

	tn1 = deleteNodeL2C(&tn, tn);
	disposeListL2C(&tn1); listOutL2C(tn, 1);

	disposeListL2C(&tn);
	return 0;
}
