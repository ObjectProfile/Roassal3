Extension { #name : 'RSSelfLoopCPController' }

{ #category : '*Roassal-Examples' }
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
		(from isNotNil and: [ to isNotNil ]) ifTrue: [
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
	^ canvas open
]
