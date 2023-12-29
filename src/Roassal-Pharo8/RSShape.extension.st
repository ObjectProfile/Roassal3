Extension { #name : #RSShape }

{ #category : #'*Roassal-Pharo8' }
RSShape >> inspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite Roassal
		title: ['Shape'];
		initializeCanvas: [ self canvasForInspector ]
]
