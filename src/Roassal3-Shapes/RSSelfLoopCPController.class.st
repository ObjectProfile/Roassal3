"
Used for straight lines and self loop lines
"
Class {
	#name : #RSSelfLoopCPController,
	#superclass : #RSAbstractCPController,
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #examples }
RSSelfLoopCPController class >> example [
	| canvas links models arrow |
	canvas := RSCanvas new.
	models := 1 to: 10.
	canvas addAll: (RSComposite models: models forEach: [:c :m |
		c addAll: {
			RSBox new
				extent: 20 asPoint;
				color: Color veryVeryLightGray;
				border: (RSBorder new color: Color black).
			(RSLabel model: m) color: Color black}.
		c]).
	canvas nodes @ RSDraggable.
	links := models collect: [ :n | (n // 2)->n ] as: OrderedCollection.
	links addFirst: 3 -> 3.
	arrow := RSShapeFactory arrow.
	arrow size: 10.
	links do: [ :assoc | | from to line |
		from := canvas shapeFromModel: assoc key.
		to := canvas shapeFromModel: assoc value.
		(from notNil and: [ to notNil ]) ifTrue: [
			line := RSBezier new
				markerEnd: arrow;
				attachPoint: (RSBorderAttachPoint new endOffset: 5);
				controlPointsController: (self new);
				from: from;
				to: to.
			line color: Color black.
			canvas add: line ]
	].
	(Smalltalk globals at: #RSTreeLayout) on: canvas nodes.
	canvas zoomToFit.
	canvas open
]

{ #category : #hooks }
RSSelfLoopCPController >> controlPointsFor: aLine [
	| ap from to |
	ap := aLine attachPoint.

	aLine from = aLine to
		ifTrue: [ ^ self selfLoopControlPointsFor: aLine ].

	from := ap startingPointOf: aLine.
	to := ap endingPointOf: aLine.

	^ Array with: from with: to
]

{ #category : #hooks }
RSSelfLoopCPController >> selfLoopControlPointsFor: aLine [
	| temp from to delta matrix |
	temp := aLine from.
	delta := 50.
	matrix := temp parent globalMatrix.
	from := matrix transform: temp encompassingRectangle topCenter.
	to := matrix transform: temp encompassingRectangle leftCenter.
	^ Array
		with: from
		with: from - (0 @ delta)
		with: to - (delta @ 0)
		with: to - (5 @ 0)
]
