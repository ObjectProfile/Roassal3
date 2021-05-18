#include <gvc.h>

int myFoo( void ) {
	return 43;
}


int runGraphviz2(FILE *fpInput, FILE *fpOutput) {
	GVC_t *gvc; 
	Agraph_t *g;

	gvc = gvContext();

	g = agread(fpInput, 0);
    gvLayout(gvc, g, "dot");
    gvRender(gvc, g, "plain", fpOutput);
    gvFreeLayout(gvc, g);
	agclose(g);
    return (gvFreeContext(gvc));
}

// If it returns -10, then it cannot open the input file.
// If it cannot write the result, return -20
int runGraphviz(char* filenameInput, char* filenameOutput) {
	FILE *fpInput;
	FILE *fpOutput;
	int result = 0;

	fpInput = fopen(filenameInput, "r");
	if(fpInput == NULL) return -10;

	fpOutput = fopen(filenameOutput, "w");
	if(fpOutput == NULL) return -20;

	result = runGraphviz2(fpInput, fpOutput);

	fclose(fpInput);
	fclose(fpOutput);

	return result;
}

int main(int argc, char **argv)
{
GVC_t *gvc; Agraph_t *g; FILE *fp;
gvc = gvContext();
if (argc > 1)
fp = fopen(argv[1], "r");
else
fp = stdin;
g = agread(fp, 0);
    gvLayout(gvc, g, "dot");
    gvRender(gvc, g, "plain", stdout);
    gvFreeLayout(gvc, g);
agclose(g);
    return (gvFreeContext(gvc));
}
