Extension { #name : #RSShape }

{ #category : #'*Roassal3-Inspector' }
RSShape >> gtCanvasForInspector [
	| view copy |
	view := RSCanvas new.
	copy := self copy.
	view addShape: copy.
	view @ RSChessBackground.
	^ view
]

{ #category : #'*Roassal3-Inspector' }
RSShape >> gtInspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Shape'];
		initializeCanvas: [ self gtCanvasForInspector ]
]
