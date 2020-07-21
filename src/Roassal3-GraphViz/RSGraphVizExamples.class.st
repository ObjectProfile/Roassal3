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

{ #category : #examples }
RSGraphVizExamples >> example03Basic [
	<script: 'self new example03Basic'>
	| canvas node converter process |
	canvas := RSCanvas new.
	node := [ :str | | ellipse label |
		ellipse := RSEllipse new withBorder; noPaint.
		label := RSLabel new text: str.
		ellipse extent: label extent + 20.
		RSComposite new
			model: str;
			children: {ellipse. label };
			yourself ].
	canvas add: (node value: 'Hello').
	canvas add: (node value: 'World').
	canvas nodes @ RSDraggable.
	canvas add: (RSArrowedLine new
		withBorderAttachPoint;
		from: canvas nodes first;
		to: canvas nodes second;
		yourself).
	converter := RSDotConverter new.
	canvas accept: converter.
	
	process := OSSUnixSubprocess new
		command: '/usr/local/bin/dot';
		arguments: {'-Tsvg'};
		workingDirectory: FileLocator home fullName;
		addAllEnvVariablesFromParentWithoutOverride;
		redirectStdout;
		redirectStderr;
		redirectStdin;
		run.

	process stdinStream
		nextPutAll: converter stream contents;
		close.		
	process waitForExit.
	process stdoutStream upToEndOfFile inspect.
	process closeAndCleanStreams.
	canvas open.
	


]

{ #category : #examples }
RSGraphVizExamples >> example04Layout [
	<script: 'self new example04Layout'>
	| canvas node |
	canvas := RSCanvas new.
	node := [ :str | | ellipse label |
		ellipse := RSEllipse new withBorder; noPaint.
		label := RSLabel new text: str.
		ellipse extent: label extent + 20.
		RSComposite new
			model: str;
			children: {ellipse. label };
			yourself ].
	canvas add: (node value: 'Hello').
	canvas add: (node value: 'World').
	canvas nodes @ RSDraggable.
	canvas add: (RSArrowedLine new
		withBorderAttachPoint;
		from: canvas nodes first;
		to: canvas nodes second;
		yourself).
	RSGraphVizLayout on: canvas nodes.
	canvas open.
	


]

{ #category : #examples }
RSGraphVizExamples >> example05Layout [
	<script: 'self new example05Layout'>
	| canvas node labeled |
	canvas := RSCanvas new.
	"node := [ :str | | ellipse label |
		ellipse := RSEllipse new withBorder; noPaint.
		label := RSLabel new text: str.
		ellipse extent: label extent + 20.
		RSComposite new
			model: str;
			children: {ellipse. label };
			draggable;
			yourself ]."
	node := [ :str | | label |
		label := RSLabel new text: str.
		RSEllipse new 
			model: str;
			extent: label extent + 20;
			noPaint;
			withBorder;
			draggable;
			yourself ].
	
	Collection withAllSubclassesDo: [ :cls | 
		canvas add: (node value: cls name).
		 ].
	
	RSEdgeBuilder arrowedLine 
		canvas: canvas;
		withBorderAttachPoint;
		shapes: canvas nodes;
		connectFrom: [:str | str asClass superclass name ].
	
	RSGraphVizLayout on: canvas nodes.
	labeled := RSLabeled new.
	labeled location center; middle.
	canvas nodes @ labeled.
	canvas @ RSCanvasController.
	canvas open.
	


]

{ #category : #examples }
RSGraphVizExamples >> example06UniFamilyTree [
	<script: 'self new example06UniFamilyTree'>
	| canvas nodeBlock labeled edges nodes |
	canvas := RSCanvas new.
	
	nodeBlock := [ :str | | label |
		label := RSLabel new text: str.
		RSEllipse new 
			model: str;
			extent: label extent + 20;
			noPaint;
			withBorder;
			draggable;
			yourself ].
	edges := self unixFamilyTree.
	nodes := (edges collect: [ :asso | asso key ] as: Set).
	nodes := nodes addAll: (edges collect: [ :asso | asso value ] as: Set).
	canvas addAll: (nodes collect: nodeBlock).
	RSEdgeBuilder arrowedLine 
		canvas: canvas;
		withBorderAttachPoint;
		shapes: canvas nodes;
		useAssociations: edges.
	
	RSGraphVizLayout on: canvas nodes.
	"RSTreeLayout on: canvas nodes."
	labeled := RSLabeled new.
	labeled location center; middle.
	canvas nodes @ labeled.
	canvas @ RSCanvasController.
	canvas open.
	


]

{ #category : #examples }
RSGraphVizExamples >> unixFamilyTree [
	^ {'5th Edition' -> '6th Edition'.
	'5th Edition' -> 'PWB 1.0'.
	'6th Edition' -> 'LSX'.
	'6th Edition' -> '1 BSD'.
	'6th Edition' -> 'Mini Unix'.
	'6th Edition' -> 'Wollongong'.
	'6th Edition' -> 'Interdata'.
	'Interdata' -> 'Unix/TS 3.0'.
	'Interdata' -> 'PWB 2.0'.
	'Interdata' -> '7th Edition'.
	'7th Edition' -> '8th Edition'.
	'7th Edition' -> '32V'.
	'7th Edition' -> 'V7M'.
	'7th Edition' -> 'Ultrix-11'.
	'7th Edition' -> 'Xenix'.
	'7th Edition' -> 'UniPlus+'.
	'V7M' -> 'Ultrix-11'.
	'8th Edition' -> '9th Edition'.
	'1 BSD' -> '2 BSD'.
	'2 BSD' -> '2.8 BSD'.
	'2.8 BSD' -> 'Ultrix-11'.
	'2.8 BSD' -> '2.9 BSD'.
	'32V' -> '3 BSD'.
	'3 BSD' -> '4 BSD'.
	'4 BSD' -> '4.1 BSD'.
	'4.1 BSD' -> '4.2 BSD'.
	'4.1 BSD' -> '2.8 BSD'.
	'4.1 BSD' -> '8th Edition'.
	'4.2 BSD' -> '4.3 BSD'.
	'4.2 BSD' -> 'Ultrix-32'.
	'PWB 1.0' -> 'PWB 1.2'.
	'PWB 1.0' -> 'USG 1.0'.
	'PWB 1.2' -> 'PWB 2.0'.
	'USG 1.0' -> 'CB Unix 1'.
	'USG 1.0' -> 'USG 2.0'.
	'CB Unix 1' -> 'CB Unix 2'.
	'CB Unix 2' -> 'CB Unix 3'.
	'CB Unix 3' -> 'Unix/TS++'.
	'CB Unix 3' -> 'PDP-11 Sys V'.
	'USG 2.0' -> 'USG 3.0'.
	'USG 3.0' -> 'Unix/TS 3.0'.
	'PWB 2.0' -> 'Unix/TS 3.0'.
	'Unix/TS 1.0' -> 'Unix/TS 3.0'.
	'Unix/TS 3.0' -> 'TS 4.0'.
	'Unix/TS++' -> 'TS 4.0'.
	'CB Unix 3' -> 'TS 4.0'.
	'TS 4.0' -> 'System V.0'.
	'System V.0' -> 'System V.2'.
	'System V.2' -> 'System V.3'}.
]
