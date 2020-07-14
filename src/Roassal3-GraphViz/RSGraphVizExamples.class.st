"
read 

https://graphviz.org/
"
Class {
	#name : #RSGraphVizExamples,
	#superclass : #Object,
	#category : #'Roassal3-GraphViz'
}

{ #category : #examples }
RSGraphVizExamples >> example01Basic [
	<script: 'self new example01Basic'>
	"OSSUnixSubprocess new
	command: '/usr/bin/which';
	arguments: (Array with: 'dot');
	addAllEnvVariablesFromParentWithoutOverride;
	redirectStdout;
	terminateOnShutdown;
	runAndWaitOnExitDo: [ :process :outString :errString | 
		^ process isSuccess 
			ifTrue: [ outString trim ]
			ifFalse: [ self error: 'ffmpeg not found' ]
		]"
	| process |
process := OSSUnixSubprocess new
	command: '/usr/local/bin/dot';
	arguments: {'-Tjson'};
	workingDirectory: FileLocator home fullName;
	addAllEnvVariablesFromParentWithoutOverride;
	redirectStdout;
	redirectStderr;
	redirectStdin;
	run.

process stdinStream
	nextPutAll: '
digraph digraph G {Hello->World}
';
	close.		
process waitForExit.
process stdoutStream upToEndOfFile inspect.
process closeAndCleanStreams.
]

{ #category : #examples }
RSGraphVizExamples >> example02Basic [
	<script: 'self new example02Basic'>
	RSGraphVizExamples fromString: '
## "It encodes the so-called philosophers dilemma.  Neato pretty much approximates the way how humans would layout the graph." Contributed by Manfred Jeusfield.
## Command to generate the layout: "neato -Tpng thisfile > thisfile.png" 


digraph PhiloDilemma {
node [shape=box];  bec3; rel3; bec2; rel2; acq2; acq3; bec1; rel1; acq1;
node [shape=circle,fixedsize=true,width=0.9];  hu3; th3; ri3; ea3; hu2; th2; ri2; ea2; hu1; th1; ri1; ea1;
ri3->acq2;
ri3->acq3;
hu3->acq3;
bec3->hu3;
th3->bec3;
rel3->th3;
rel3->ri3;
ea3->rel3;
acq3->ea3;
ri2->acq1;
ri2->acq2;
hu2->acq2;
bec2->hu2;
th2->bec2;
rel2->th2;
rel2->ri2;
ea2->rel2;
acq2->ea2;
ri1->acq3;
ri1->acq1;
hu1->acq1;
bec1->hu1;
th1->bec1;
rel1->th1;
rel1->ri1;
ea1->rel1;
acq1->ea1;

overlap=false
label="PetriNet Model PhiloDilemma\nExtracted from ConceptBase and layed out by Graphviz "
fontsize=12;
}
' "a RSComposite"

"canvas asDOT.""aString"

"RSGraphVizLayout on: canvas shapes."

]
