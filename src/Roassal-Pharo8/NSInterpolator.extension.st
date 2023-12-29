Extension { #name : #NSInterpolator }

{ #category : #'*Roassal-Pharo8' }
NSInterpolator >> gtInspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite Roassal
		title: ['Interpolator'];
		initializeCanvas: [ self gtCanvasForInspector ]
]
