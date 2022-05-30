Extension { #name : #RSAVL }

{ #category : #'*Roassal3-Inspector' }
RSAVL >> createCanvas [
	| canvas children |
	canvas := RSCanvas new.
	children := self allChildren collect: [ :child | self createNode: child ].
	canvas addAll: children.
	RSLineBuilder line
		canvas: canvas;
		withBorderAttachPoint;
		markerEnd: (RSShapeFactory arrow size: 10);
		shapes: children;
		connectToAll: [ :child | child children ].
	RSTreeLayout on: children.
	canvas @ RSCanvasController simple.
	^ canvas
]

{ #category : #'*Roassal3-Inspector' }
RSAVL >> createNode: node [ 
	| label w h back |
	label := RSLabel new 
		text: node contents asString;
		color: 'black';
		yourself.
	w := label width.
	h := label height.
	back :=RSEllipse new
		size: (w max: h)+5;
		border: (RSBorder new color: 'black');
		color: (node isBalanced
			ifTrue: ['green']
			ifFalse: ['red']);
		yourself.
		
	^ { back. label } asShape
		model: node;
		padding: 7;
		draggable;
		yourself.
]

{ #category : #'*Roassal3-Inspector' }
RSAVL >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'AVL'>
	^ SpRoassal3InspectorPresenter new
		canvas: self createCanvas;
		yourself 
]
