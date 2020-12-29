"
RSBezier represents a bezier lines of one and 2 control points.

Here is an example:
```Smalltalk
	c := RSCanvas new.
	c add: (RSBezier new
		color: Color red;
		controlPoints:
			{(0 @ 0).
			(100 @ 100).
			(200 @ 0).
			(300 @ 100)}).
	c 
```

Another example:
```Smalltalk
	v := RSCanvas new.
	
	e1 := RSBox new size: 100; color: Color blue.
	e2 := RSBox new size: 100; color: Color red.
	e1 translateTo: 100 @ -200.

	e1 @ RSDraggable.
	e2 @ RSDraggable.
	v
		add: e1;
		add: e2.
	
	l := RSBezier new
		withVerticalAttachPoint;
		from: e1;
		to: e2;
		controlPointsBlock: [ :a :b | 
			| mid |
			mid := (a + b) / 2.
			Array
				with: a
				with: a x @ mid y
				with: b x @ mid y
				with: b ];
		yourself.
	v add: l.
	v open
```

Here is an example of a bezier line with a marker
```
b := RSCanvas  new.
b addAll: ((1 to: 3) collect: [:i |
	RSEllipse new
		model: i;
		size: 5]).

b nodes @ RSDraggable.

marker := RSPolygon new
		points: { -5@5. 0@0. 5@5. 0@0 };
		extent: 2 @ 2;
		color: Color red;
		withBorder;
		asMarker.

RSEdgeBuilder verticalBezier
	color: Color red translucent;
	canvas: b;
	withVerticalAttachPoint;
	noRepetition;
	markerEnd: marker;
	useAssociations: { 1 -> 2 . 2 -> 3 . 1 -> 2}.
	
RSVerticalLineLayout on: b nodes.

b @ RSCanvasController.
b open
```
"
Class {
	#name : #RSBezier,
	#superclass : #RSAbstractControlPointsLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #testing }
RSBezier >> basicIncludesPoint: aPoint [
	| cp |
	cp := self controlPoints.
	cp size = 2 ifTrue: [ 
		^ aPoint
			onLineFrom: cp first
			to: cp second
			within: self includedRadius
		 ].
	^ false
]

{ #category : #visiting }
RSBezier >> buildPathOn: visitor [
	visitor buildBezierPath: self.
]

{ #category : #accessing }
RSBezier >> controlPoints: anArrayOfPoints [
	self
		assert: anArrayOfPoints notNil 
		description: 'The argument can not be nil';
		assert: (anArrayOfPoints size between: 2 and: 4)
		description: 'The array size must be between 2 and 4 points'.
	super controlPoints: anArrayOfPoints
]

{ #category : #initialization }
RSBezier >> initialize [
	super initialize.
	controlPoints := { 0@0. 100@100 }.
]
