Extension { #name : #RSShape }

{ #category : #'*Roassal3-Pharo8' }
RSShape >> inspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Shape'];
		initializeCanvas: [ self canvasForInspector ]
]
