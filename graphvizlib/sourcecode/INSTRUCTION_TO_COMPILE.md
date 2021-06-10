gcc simple.c -c -I/usr/local/Cellar/graphviz/2.44.1/include/graphviz 

-> produce a simple.o

gcc *.o /usr/local/Cellar/graphviz/2.44.1/lib/libgvc.6.dylib /usr/local/Cellar/graphviz/2.44.1/lib/libcgraph.6.dylib -shared -o liball.dylib

-> produce liball.dylib


In Pharo / GT:

runningGraphvizInputFilename: filenameInput outputFilename: filenameOutput
	"
	self new runningGraphvizInputFilename: 'hello.dot' outputFilename: 'myresult.txt'
	"
	
	^ self ffiCall: #( int runGraphviz ( char * filenameInput , char* filenameOutput) ) library: '/Users/alexandrebergel/Desktop/TestC/liball.dylib'

