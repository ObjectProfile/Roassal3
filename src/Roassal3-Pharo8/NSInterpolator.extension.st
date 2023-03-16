Extension { #name : #NSInterpolator }

{ #category : #'*Roassal3-Pharo8' }
NSInterpolator >> gtInspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Interpolator'];
		initializeCanvas: [ self gtCanvasForInspector ]
]
