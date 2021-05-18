"
TODO
"
Class {
	#name : #RSGraphVizLayout,
	#superclass : #RSLineDrivenLayout,
	#instVars : [
		'dotConverter',
		'scale',
		'dotDescription'
	],
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #'instance creation' }
RSGraphVizLayout class >> digraph [
	^ self new digraph
]

{ #category : #'instance creation' }
RSGraphVizLayout class >> neato [
	^ self new neato
]

{ #category : #'instance creation' }
RSGraphVizLayout class >> strict [
	^ self new strict
]

{ #category : #'instance creation' }
RSGraphVizLayout class >> twoPi [
	^ self new twoPi
]

{ #category : #'public - configuration' }
RSGraphVizLayout >> digraph [
	^ self 
		dotConverter: RSDigraphDotConverter new;
		yourself
]

{ #category : #hook }
RSGraphVizLayout >> doExecute: shapes [
	| group process string | 
	group := shapes asGroup.
	dotDescription := self dotDescriptionOf: shapes.
	
	
	
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
		nextPutAll: dotDescription;
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

{ #category : #accessing }
RSGraphVizLayout >> dotDescription [
	"Return the dot description, after the doExecute: is executed"
	^ dotDescription asString
]

{ #category : #accessing }
RSGraphVizLayout >> dotDescriptionOf: shapes [

	| group |
	group := shapes asGroup.
	group, edges accept: dotConverter.
	^ dotConverter stream contents utf8Encoded
]

{ #category : #'initialize-release' }
RSGraphVizLayout >> initialize [
	super initialize.
	self dotConverter: RSStrictDotConverter new.
	self scale: 70 negated
]

{ #category : #'public - configuration' }
RSGraphVizLayout >> neato [
	^ self 
		dotConverter: RSNeatoDotConverter new;
		yourself
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

{ #category : #'public - configuration' }
RSGraphVizLayout >> strict [
	^ self 
		dotConverter: RSStrictDotConverter new;
		yourself
]

{ #category : #hook }
RSGraphVizLayout >> transform: aPoint [
	^ aPoint * scale
]

{ #category : #'public - configuration' }
RSGraphVizLayout >> twoPi [
	^ self 
		dotConverter: RSTwoPiDotConverter new;
		yourself
]
