Extension { #name : #RSShape }

{ #category : #'*Roassal3-Inspector' }
RSShape >> gtCanvasForInspector [
	| canvas copy |
	canvas := RSCanvas new.
	copy := self copy.
	canvas addShape: copy.
	canvas @ RSChessBackground.
	^ canvas
]

{ #category : #'*Roassal3-Inspector' }
RSShape >> gtInspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Shape'];
		initializeCanvas: [ self gtCanvasForInspector ]
]

{ #category : #'*Roassal3-Inspector' }
RSShape >> inspectorShape [
	<inspectorPresentationOrder: 90 title: 'Shape'>

	^ SpRoassal3InspectorPresenter new
		canvas: self gtCanvasForInspector;
		yourself
]
