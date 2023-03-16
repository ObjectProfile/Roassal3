"
This layout uses unix process to run dot commands, the command input is build based on roassal3 shapes
"
Class {
	#name : #RSGraphvizLayout,
	#superclass : #RSLineDrivenLayout,
	#instVars : [
		'dotConverter',
		'scale',
		'dotDescription',
		'graphvizResult'
	],
	#classInstVars : [
		'commandLocation'
	],
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #public }
RSGraphvizLayout class >> commandLocation [
	^ commandLocation ifNil: [ commandLocation := self findCommand ]
]

{ #category : #'instance creation' }
RSGraphvizLayout class >> digraph [
	^ self new digraph
]

{ #category : #public }
RSGraphvizLayout class >> findCommand [
	| process |
	process := RSUnixSubprocess new
		command: '/usr/bin/which';
		arguments: { 'dot' };
		workingDirectory: FileLocator home fullName;
		addAllEnvVariablesFromParentWithoutOverride;
		terminateOnShutdown;
		yourself.
	process stdin: 'dot' utf8Encoded.
	process runAndWait.
	^ process stdout trimBoth
]

{ #category : #'instance creation' }
RSGraphvizLayout class >> neato [
	^ self new neato
]

{ #category : #'instance creation' }
RSGraphvizLayout class >> strict [
	^ self new strict
]

{ #category : #'instance creation' }
RSGraphvizLayout class >> twoPi [
	^ self new twoPi
]

{ #category : #'public - configuration' }
RSGraphvizLayout >> digraph [
	^ self
		dotConverter: RSDigraphDotConverter new;
		yourself
]

{ #category : #hook }
RSGraphvizLayout >> doExecute: shapes [
	| group process |
	group := shapes asGroup.
	dotDescription := self dotDescriptionOf: shapes.

	process := RSUnixSubprocess new
		command: self class commandLocation;
		arguments: { '-Tplain-ext' };
		workingDirectory: FileLocator home fullName;
		addAllEnvVariablesFromParentWithoutOverride;
		terminateOnShutdown;
		yourself.

	process stdin: dotDescription.
	process runAndWait.
	graphvizResult := process stdout.
	graphvizResult ifEmpty: [ self error: process stderr. ].
	self positionShapes: group with: graphvizResult.
	process closeAndCleanStreams
]

{ #category : #accessing }
RSGraphvizLayout >> dotConverter [
	^ dotConverter
]

{ #category : #accessing }
RSGraphvizLayout >> dotConverter: aRSDotConverter [
	dotConverter := aRSDotConverter
]

{ #category : #accessing }
RSGraphvizLayout >> dotDescription [
	"Return the dot description, after the doExecute: is executed"
	^ dotDescription asString
]

{ #category : #accessing }
RSGraphvizLayout >> dotDescriptionOf: shapes [

	| group |
	group := shapes asGroup.
	group, lines accept: dotConverter.
	^ dotConverter stream contents utf8Encoded
]

{ #category : #accessing }
RSGraphvizLayout >> graphvizResult [
	"Return the graphviz result"
	^ graphvizResult
]

{ #category : #'initialize-release' }
RSGraphvizLayout >> initialize [
	super initialize.
	self dotConverter: RSStrictDotConverter new.
	self scale: 70 negated
]

{ #category : #'public - configuration' }
RSGraphvizLayout >> neato [
	^ self
		dotConverter: RSNeatoDotConverter new;
		yourself
]

{ #category : #hook }
RSGraphvizLayout >> pointsFor: line [
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
RSGraphvizLayout >> positionShapes: elements with: string [
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
			edge attachPoint: (RSGraphvizAttachPoint new points: points edge: edge).
			edge propertyAt: #points put: points.
			 ].
		 ]
]

{ #category : #hook }
RSGraphvizLayout >> runningGraphvizInputFilename: filenameInput outputFilename: filenameOutput [
	"
	self new runningGraphvizInputFilename: 'hello.dot' outputFilename: 'myresult.txt'
	"

	^ self ffiCall: #( int runGraphviz ( char * filenameInput , char* filenameOutput) ) library: GraphvizFFILibrary
]

{ #category : #accessing }
RSGraphvizLayout >> scale [
	^ scale
]

{ #category : #accessing }
RSGraphvizLayout >> scale: aNumber [
	scale := aNumber
]

{ #category : #'public - configuration' }
RSGraphvizLayout >> sfdp [
	^ self
		dotConverter: RSSFDPConverter new;
		yourself
]

{ #category : #'public - configuration' }
RSGraphvizLayout >> strict [
	^ self
		dotConverter: RSStrictDotConverter new;
		yourself
]

{ #category : #hook }
RSGraphvizLayout >> transform: aPoint [
	^ aPoint * scale
]

{ #category : #'public - configuration' }
RSGraphvizLayout >> twoPi [
	^ self
		dotConverter: RSTwoPiDotConverter new;
		yourself
]
