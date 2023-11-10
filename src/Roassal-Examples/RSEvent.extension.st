Extension { #name : 'RSEvent' }

{ #category : '*Roassal-Examples' }
RSEvent class >> example [

	| nodes links canvas captureC bubbleC capture bubble label rect |
	nodes := #(RSCanvas box1 box2 box3 box4 composite1 composite2 Triangle1).
	links := { 
		#RSCanvas -> #box1.
		#RSCanvas -> #composite1.
		#RSCanvas -> #composite2.
		#composite1 -> #box2.
		#composite1 -> #box3.
		#composite2 -> #box4.
		#composite2 -> #Triangle1.
		}.
	canvas := RSCanvas new.

	canvas addAll: (RSComposite boxesForModels: nodes).
	canvas nodes do: [ :n | n children first cornerRadius: 5 ].
	canvas nodes @ RSDraggable new.
	RSLineBuilder orthoVertical
		cornerRadii: 5;
		withVerticalAttachPoint;
		shapes: canvas nodes;
		useAssociations: links.
	RSTreeLayout new
		verticalGap: 30;
		horizontalGap: 30;
	on: canvas nodes.
	captureC := RSBlockCPController new
		block: [ :line | | a b |
			a := line from encompassingRectangle bottomLeft.
			b := line to encompassingRectangle leftCenter +(-3 @ 0).
			{  a. a x@ b y. b  } ].
	bubbleC := RSBlockCPController new
		block: [ :line | | a b |
			a := line from encompassingRectangle topRight.
			b := line to encompassingRectangle rightCenter +(3@0).
			{  a. a x@ b y. b  } ].
	capture := bubble := [ :a :b :c |
		RSBezier new
			from: (canvas shapeFromModel: a)
			to: (canvas shapeFromModel: b);
			markerStart: (RSEllipse new size: 3);
			markerEnd: (RSShapeFactory arrow size: 4);
			controlPointsController: c;
			yourself.
		 ].
	#(RSCanvas composite2 Triangle1) overlappingPairsDo: [ :a :b |
		| line |
		line := capture value: a value: b value: captureC.
		
		line color: Color red.
		canvas add: line.
		label := RSLabel text: '1 Capture'.
		label fontSize: 5.
		label color: Color red.
		label position: line controlPoints second - (label extent / 3).
		rect := RSBox new fromRectangle: label encompassingRectangle.
		rect color: (Color white alpha: 0.8).
		canvas add: rect.
		canvas add: label.
		
		line := bubble value: b value: a value: bubbleC.
		canvas add: line.
		line color: Color purple.
		label := RSLabel text: '3 Bubble'.
		label fontSize: 5.
		label color: Color purple.
		label position: line controlPoints second + (label extent / 2).
		canvas add: label.
	].
	label := RSLabel text: '2 Target'.
	label fontSize: 5.
	canvas add: label.
	label color: Color blue.
	RSLocation new below
		move: label on: (canvas shapeFromModel: #Triangle1).
	canvas @ RSCanvasController.
	^ canvas open
]
