Extension { #name : #NSOrdinalScale }

{ #category : #'*Roassal3-Inspector' }
NSOrdinalScale >> inspectorColors [
	<inspectorPresentationOrder: 0 title: 'Colors'>
	| canvas |
	canvas := RSCanvas new.
	canvas addAll: (self range collect: [ :color |
		RSEllipse new
			model: color;
			color: color;
			size: 15;
			yourself ]).
	RSVerticalLineLayout new gapSize: 0; on: canvas nodes.
	canvas @ RSCanvasController simple.
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]

{ #category : #'*Roassal3-Inspector' }
NSOrdinalScale >> inspectorColorsContext: context [
	context
		evaluator: false;
		active: (self range allSatisfy: #isColor)
]
