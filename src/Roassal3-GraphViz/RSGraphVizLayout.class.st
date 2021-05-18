"
TODO
"
Class {
	#name : #RSGraphVizLayout,
	#superclass : #RSLineDrivenLayout,
	#instVars : [
		'dotConverter',
		'scale'
	],
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #'instance creation' }
RSGraphVizLayout class >> digraph [
	^ self new 
		dotConverter: RSDigraphDotConverter new;
		yourself
]

{ #category : #'instance creation' }
RSGraphVizLayout class >> neato [
	^ self new 
		dotConverter: RSNeatoDotConverter new;
		yourself
]

{ #category : #'instance creation' }
RSGraphVizLayout class >> strict [
	^ self new 
		dotConverter: RSStrictDotConverter new;
		yourself
]

{ #category : #'instance creation' }
RSGraphVizLayout class >> twoPi [
	^ self new 
		dotConverter: RSTwoPiDotConverter new;
		yourself
]

{ #category : #hook }
RSGraphVizLayout >> doExecute: elements [
	| group fr str frOutput process string | 
	group := elements asGroup.
	group, edges accept: self dotConverter.
	
	
	
"
	fr := '/tmp/description.dot' asFileReference.
 	fr exists ifTrue: [ fr delete ].
	str := fr writeStream.
	str nextPutAll: dotConverter stream contents ""utf8Encoded"".
	str close. 
	
	frOutput := '/tmp/result.txt' asFileReference.
	frOutput exists ifTrue: [ frOutput delete ].
	
	self runningGraphvizInputFilename: '/tmp/description.dot' outputFilename: '/tmp/result.txt'.
	
	self positionShapes: group with: '/tmp/description.dot' asFileReference contents.
"	
	
	process := OSSUnixSubprocess new
		command: '/usr/local/bin/dot';
		arguments: { '-Tplain-ext' };
		workingDirectory: FileLocator home fullName;
		addAllEnvVariablesFromParentWithoutOverride;
		redirectStdout;
		redirectStderr;
		redirectStdin;
		run.

	process stdinStream
		nextPutAll: dotConverter stream contents utf8Encoded;
		close.
	process waitForExit.
	string := process stdoutStream upToEndOfFile.
	string ifEmpty: [ self error: process stderrStream upToEndOfFile. ].
	self positionShapes: group with: string.
	process closeAndCleanStreams.
]

{ #category : #accessing }
RSGraphVizLayout >> dotConverter [
	^ dotConverter
]

{ #category : #accessing }
RSGraphVizLayout >> dotConverter: aRSDotConverter [
	dotConverter := aRSDotConverter
]

{ #category : #'initialize-release' }
RSGraphVizLayout >> initialize [
	super initialize.
	self dotConverter: RSStrictDotConverter new.
	self scale: 70 negated
]

{ #category : #hook }
RSGraphVizLayout >> pointsFor: line [
	| points n |
	n := line next asNumber.
	points := (1 to: n) collect: [ :i | 
		| x y |
		x := line next asNumber.
		y := line next asNumber.
		self transform: x@y.
		] as: Array.
	^ points
]

{ #category : #hook }
RSGraphVizLayout >> positionShapes: elements with: string [
	| nodeIndex |
	string ifEmpty: [ self error: 'Error in Dot converter' ].
	nodeIndex := 1.
	
	string linesDo: [ :l | 
		| line type |
		line := (' ' split: l) readStream.
		type := line next.
		type = #node ifTrue: [ 
			| x y |
			line next.
			x := line next asNumber.
			y := line next asNumber.
			
			(elements at: nodeIndex) translateTo: (self transform: x@y).
			nodeIndex := nodeIndex + 1.
			 ].
		type = #edge ifTrue: [
			| points tail head edge |
			tail := line next asNumber.
			head := line next asNumber.
			tail := elements at: tail.
			head := elements at: head.
			points := self pointsFor: line.
			edge := tail connectedEdges detect: [ :ed | ed to = head ].
			edge attachPoint: (RSGraphVizAttachPoint new points: points edge: edge).
			edge propertyAt: #points put: points.
			 ].
		 ].
]

{ #category : #hook }
RSGraphVizLayout >> runningGraphvizInputFilename: filenameInput outputFilename: filenameOutput [
	"
	self new runningGraphvizInputFilename: 'hello.dot' outputFilename: 'myresult.txt'
	"
	
	^ self ffiCall: #( int runGraphviz ( char * filenameInput , char* filenameOutput) ) library: GraphvizFFILibrary
]

{ #category : #accessing }
RSGraphVizLayout >> scale [
	^ scale
]

{ #category : #accessing }
RSGraphVizLayout >> scale: aNumber [
	scale := aNumber
]

{ #category : #hook }
RSGraphVizLayout >> transform: aPoint [
	^ aPoint * scale
]
