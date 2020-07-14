"
TODO
"
Class {
	#name : #RSGraphVizLayout,
	#superclass : #RSLayout,
	#category : #'Roassal3-GraphViz'
}

{ #category : #hook }
RSGraphVizLayout >> doExecute: elements [
	|canvas converter process | 
	canvas := elements first canvas.
	converter := RSDotConverter new.
	canvas accept: converter.
	
	process := OSSUnixSubprocess new
		command: '/usr/local/bin/dot';
		arguments: {'-Tjson0'};
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
	self positionShapes: elements asGroup with: process stdoutStream upToEndOfFile.
	process closeAndCleanStreams.
]

{ #category : #hook }
RSGraphVizLayout >> positionShapes: elements with: string [
	| dict |
	dict := STON fromString: string.
	(dict at: #objects) do: [ :obj |
		| pos name shape |
		pos :=  obj at: #pos.
		name := obj at: #name.
		shape := elements shapeFromModel: name.
		pos := pos splitOn: $,. 
		shape position: pos first asNumber @ pos second asNumber negated ].
	


]
