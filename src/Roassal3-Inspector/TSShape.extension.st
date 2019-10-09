Extension { #name : #TSShape }

{ #category : #'*Roassal3-Inspector' }
TSShape >> gtCanvasForInspector [
	| view copy |
	view := TSCanvas new.
	copy := self copy.
	view addShape: copy.
	view @ TSChessBackground.
	^ view
]

{ #category : #'*Roassal3-Inspector' }
TSShape >> gtInspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Shape'];
		initializeCanvas: [ self gtCanvasForInspector ]
]
