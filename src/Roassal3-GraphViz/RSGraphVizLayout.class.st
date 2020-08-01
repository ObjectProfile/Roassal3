"
TODO
"
Class {
	#name : #RSGraphVizLayout,
	#superclass : #RSEdgeDrivenLayout,
	#category : #'Roassal3-GraphViz'
}

{ #category : #hook }
RSGraphVizLayout >> doExecute: elements [
	| converter process group | 
	group := elements asGroup.
	converter := RSDotConverter new.
	group, edges accept: converter.
	
	process := OSSUnixSubprocess new
		command: '/usr/local/bin/dot';
		"arguments: {'-Tjson0'};"
		arguments: { '-Tplain-ext' };
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
	self positionShapes: group with: process stdoutStream upToEndOfFile.
	process closeAndCleanStreams.
]

{ #category : #hook }
RSGraphVizLayout >> positionShapes: elements with: string [
	| scale nodeIndex edgeIndex transform |
	scale := 70.
	edgeIndex := nodeIndex := 1.
	transform := [ :p | 
		p * (scale negated) ].
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
