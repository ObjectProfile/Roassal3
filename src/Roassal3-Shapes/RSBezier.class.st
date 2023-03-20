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
canvas := RSCanvas new.
 
box1 := RSBox new color: Color blue.
box2 := RSBox new color: Color red.
box2 translateTo: 100 @ -200.

box1 @ RSDraggable.
box2 @ RSDraggable.
canvas add: box1; add: box2.
 
bezierLine := RSBezier new
	withVerticalAttachPoint;
	from: box1;
	to: box2;
	controlPointsController: (
			RSBlockCPController new
				block: [ :aLine |
					| mid |
   					mid := (box1 position + box2 position) / 2.
					{(box1 position) . 
					(box1 position x @ mid y) .
					(box2 position x @ mid y) .
					(box2 position)} ];
				yourself);
  yourself.
canvas add: bezierLine.
canvas zoomToFit.
canvas open
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

{ #category : #examples }
RSBezier class >> exampleBezier [
	| bezier |
	bezier := self new.
	bezier controlPoints: {0@0. 100@ -50.  0@ -100. 50@ 0}.
	bezier inspect
]

{ #category : #examples }
RSBezier class >> exampleControlPointsController [
	| bezier controller points |
	bezier := self new.
	points := {0@0. 100@ -50.  0@ -100. 50@ 0} collect: [:point |
		RSCircle new
			radius: 5;
			position: point;
			draggable;
			yourself ].

	controller := RSCustomCPController new
		models: points;
		yourself.
	bezier controlPointsController: controller.

	RSCanvas new
		add: bezier;
		addAll: points;
		open
]

{ #category : #converting }
RSBezier >> asDeCasteljauLine [

	^ RSdeCasteljauLine new
		  controlPoints: self controlPoints;
		  yourself
]

{ #category : #testing }
RSBezier >> basicIncludesPoint: aPoint [
	"Not perfect but close enough"
	| cp lines ir |
	cp := self controlPoints.
	ir := self includedRadius.
	cp size = 2 ifTrue: [
		^ aPoint
			onLineFrom: cp first
			to: cp second
			within: ir
		 ].
	lines := self lines.
	lines ifNil: [ ^ false ].
	^ (1 to: lines size - 1) anySatisfy: [ :i |
		| p1 p2 |
		p1 := lines at: i.
		p2 := lines at: i + 1.
		(aPoint
			onLineFrom: p1
			to: p2
			within: ir )
		 ]
]

{ #category : #visiting }
RSBezier >> buildPathOn: visitor [
	visitor buildBezierPath: self
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

{ #category : #composing }
RSBezier >> firstC1Point [

	^ self controlPoints second reflectedAbout: self controlPoints first
]

{ #category : #initialization }
RSBezier >> initialize [
	super initialize.
	controlPoints := { 0@0. 100@100 }
]

{ #category : #composing }
RSBezier >> joinC1Last: aBezier [

	^ self class new
		  controlPoints: { 
				  self controlPoints last.
				  self lastC1Point.
				  aBezier firstC1Point.
				  aBezier controlPoints first };
		  yourself
]

{ #category : #composing }
RSBezier >> lastC1Point [

	^ (self controlPoints atLast: 1) reflectedAbout:
		  self controlPoints last
]

{ #category : #private }
RSBezier >> lines [
	| c b a via1 via2 start end cp |
	cp := controlPoints.
	cp size <3 ifTrue: [ ^ nil ].
	start := cp first.
	via1 := cp second.
	via2 := cp third.
	end := cp size = 3
		ifTrue: [ via2 ]
		ifFalse: [ cp fourth ].
	c := 3 * (via1 - start).
	b := 3 * (via2 - via1) - c.
	a := end - start - c - b.

	^ (0 to: 1 by: 0.2) collect: [ :t |
		a * (t raisedTo: 3) + (b * (t * t)) + (c * t) + start.
		]
]

{ #category : #composing }
RSBezier >> reversed [

	^ self class new
		  controlPoints: self controlPoints reversed;
		  yourself
]

{ #category : #composing }
RSBezier >> split: aBlock [

	| a b linspace firstLine secondLine thirdLine |
	a := self controlPoints second.
	b := self controlPoints third.

	linspace := aBlock value: a value: b.

	^ linspace ifNotEmpty: [ 
		  firstLine := self class new
			               controlPoints: { 
					               self controlPoints first.
					               a.
					               linspace second.
					               linspace third };
			               yourself.

		  thirdLine := self class new
			               controlPoints: { 
					               (linspace atLast: 3).
					               (linspace atLast: 2).
					               b.
					               self controlPoints last };
			               yourself.

		  secondLine := firstLine joinC1Last: thirdLine.

		  { 
			  firstLine.
			  secondLine.
			  thirdLine } ]
]

{ #category : #composing }
RSBezier >> splitXrandom: random convex: direction lessThanBound: aBound [

	^ self split: [ :a :b | 
		  (a x - b x) abs < aBound
			  ifTrue: [ {  } ]
			  ifFalse: [ 
				  | y ys n |
				  n := 7.

				  y := (a y + b y) halved.

				  ys := ((1 to: n) collect: [ :i | 
					         random next y abs * direction + y ]) 
					        exponentiallyWeighted: 0.5.

				  ((a x to: b x) linspace: n) withIndexCollect: [ :x :i | 
					  x @ (ys at: i) ] ] ]
]

{ #category : #composing }
RSBezier >> splitYrandom: random convex: direction lessThanBound: aBound [

	^ self split: [ :a :b | 
		  (a y - b y) abs < aBound
			  ifTrue: [ {  } ]
			  ifFalse: [ 
				  | x xs n |
				  n := 7.

				  x := (a x + b x) halved.

				  xs := ((1 to: n) collect: [ :i | 
					         random next x abs * direction + x ]) 
					        exponentiallyWeighted: 0.5.

				  ((a y to: b y) linspace: n) withIndexCollect: [ :y :i | 
					  (xs at: i) @ y ] ] ]
]
