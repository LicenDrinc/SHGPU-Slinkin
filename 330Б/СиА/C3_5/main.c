#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "treeunit.h"

int main()
{
	PTree tree = NULL, tree1 = NULL;
	pushNTree(&tree, createNTree(5));
	pushNTree(&tree, createNTree(3));
	pushNTree(&tree, createNTree(7));
	pushNTree(&tree, createNTree(-1));
	pushNTree(&tree, createNTree(-4));
	pushNTree(&tree, createNTree(2));
	pushNTree(&tree, createNTree(1000));
	pushNTree(&tree, createNTree(4));

	printf("pre-order\t "); printNTree(tree, 1); printf("\n");
	printf("in-order\t "); printNTree(tree, 2); printf("\n");
	printf("post-order\t "); printNTree(tree, 3); printf("\n");
	printf("rev-pre-order\t "); printNTree(tree, 4); printf("\n");
	printf("rev-in-order\t "); printNTree(tree, 5); printf("\n");
	printf("rev-post-order\t "); printNTree(tree, 6); printf("\n");
	printAltNTree(tree, 0);

	printf("max deepth: %d\n", maxDeepthNTree(tree));
	printf("count: %d\n", countNTree(tree));
	printf("balanced: %d\n", balancedNTree(tree));

	if (tree1 = findNTree(tree, 4))
		printf("found and deepth: %d\n\n", deepthNTree(tree, tree1));
	else printf("not found\n\n");
	
	free(pullNTree(&tree, 1000));
	printAltNTree(tree, 0);
	printf("balanced: %d\n\n", balancedNTree(tree));
	
	free(pullNTree(&tree, 3));
	printAltNTree(tree, 0);
	printf("balanced: %d\n\n", balancedNTree(tree));

	free(pullNTree(&tree, 5));
	printAltNTree(tree, 0);
	printf("balanced: %d\n", balancedNTree(tree));
	
	/*
	free(pullNTree(&tree, -4));
	free(pullNTree(&tree, -1));
	free(pullNTree(&tree, 2));
	free(pullNTree(&tree, 4));
	free(pullNTree(&tree, 7));
	printAltNTree(tree, 0);
	*/
	
	destroyNTree(&tree);
	printf("\ndestroy\nmax deepth: %d\n", maxDeepthNTree(tree));
	printf("count: %d\n", countNTree(tree));
	printf("balanced: %d\n", balancedNTree(tree));
}
