"
TODO
"
Class {
	#name : #RSGraphVizLayout,
	#superclass : #RSLineDrivenLayout,
	#instVars : [
		'dotConverter'
	],
	#category : #'Roassal3-GraphViz'
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
	| process group string | 
	group := elements asGroup.
	group, edges accept: self dotConverter.
	
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
		nextPutAll: dotConverter stream contents;
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
	self dotConverter: RSStrictDotConverter new
]

{ #category : #hook }
RSGraphVizLayout >> positionShapes: elements with: string [
	| scale nodeIndex edgeIndex transform |
	scale := 70.
	edgeIndex := nodeIndex := 1.
	transform := [ :p | 
		p * (scale negated) ].
	string ifEmpty: [ self error: 'Error in Dot converter' ].
	
	string linesDo: [ :l | 
		| line type |
		line := (' ' split: l) readStream.
		type := line next.
		type = #node ifTrue: [ 
			| x y |
			line next.
			x := line next asNumber.
			y := line next asNumber.
			
			(elements at: nodeIndex) translateTo: (transform value: x@y).
			nodeIndex := nodeIndex + 1.
			 ].
		type = #edge ifTrue: [
			| n points x y |
			line next."tail"
			line next."head"
			n := line next asNumber.
			points := Array new: n.
			1 to: n do: [ :i | 
				x := line next asNumber.
				y := line next asNumber.
				points at: i put: (transform value: x@y) ].
			(edges at: edgeIndex) propertyAt: #points put: points .
			edgeIndex := edgeIndex + 1.
			 ].
		 ].
]
