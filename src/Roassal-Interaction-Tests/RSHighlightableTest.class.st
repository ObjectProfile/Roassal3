Class {
	#name : 'RSHighlightableTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Interaction-Tests-Core',
	#package : 'Roassal-Interaction-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
RSHighlightableTest >> testBasic [

	| c shapes previousColor highlight |
	c := RSCanvas new.
	shapes := (1 to: 10) collect: [ :n | RSEllipse new size: 20; model: n ] as: RSGroup.
	c addAll: shapes.
	RSGridLayout on: shapes.

	previousColor := shapes fifth color.
	highlight := RSHighlightable new.
	highlight doHighlight: shapes fifth.
	self assert: shapes fifth color equals: previousColor.

	highlight record: shapes fifth selector: #color value: Color blue.
	self assert: shapes fifth color equals: Color blue.

	highlight restore: shapes fifth selector: #color.
	self assert: shapes fifth color equals: previousColor
]

{ #category : 'tests' }
RSHighlightableTest >> testHighlightAllShapes [

	| h c |
	c := RSCanvas new.
	c addAll: (RSBox models: (1 to: 10)).

	h := RSHighlightable red.

	c nodes @ h.
	h doHighlightShapes: c nodes.

	self assert:
		(c nodes allSatisfy: [ :shape | shape color = Color red ])
]

{ #category : 'tests' }
RSHighlightableTest >> testHighlightAllShapesThenHighlightNothing [

	| h c defaultColor |
	c := RSCanvas new.
	c addAll: (RSBox models: (1 to: 10)).
	defaultColor := c nodes first color.
	h := RSHighlightable red.

	c nodes @ h.
	h doHighlightShapes: c nodes.
	h doHighlightShapes: {  } onCanvas: c.

	self assert:
		(c nodes allSatisfy: [ :shape | shape color = defaultColor ])
]

{ #category : 'tests' }
RSHighlightableTest >> testHighlightShapes [

	| interaction canvas defaultColor |
	canvas := RSCanvas new.
	canvas addAll: (RSBox models: (1 to: 10)).
	defaultColor := canvas nodes first color.
	interaction := RSHighlightable red.

	canvas nodes @ interaction.
	interaction doHighlightShapes: (OrderedCollection with: canvas nodes first).
	self assert: canvas nodes first color equals: Color red.
	self assert: (canvas nodes allButFirst allSatisfy: [ :shape |
			 shape color = defaultColor ])
]

{ #category : 'tests' }
RSHighlightableTest >> testSameModel [

	| values c boxes |
	values := #(1 1 2 2 2 2 3 3 3 4 4 5 5 5 5 ).

	c := RSCanvas new.
	boxes := values collect: [ :vv | RSBox new size: 10; model: vv ] as: RSGroup.
	c addAll: boxes.
	boxes @ RSPopup.
	boxes @ (RSHighlightable sameModel: c).
	RSGridLayout on: boxes.

	c nodes first announce: RSMouseEnter
]

{ #category : 'tests' }
RSHighlightableTest >> testWithEdges [
	| canvas shapes interaction |
	canvas := RSCanvas new.
	shapes := (1 to: 20) collect: [ :i |
		RSBox new
			size: 10;
			model: i;
			draggable;
			withBorder;
			yourself ].
	shapes := shapes asGroup.
	RSLineBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	canvas edges do: #withBorder.
	canvas addAll: shapes.
	RSClusterTreeLayout on: shapes.

	interaction := RSHighlightable red.
	interaction withLines.
	shapes @ interaction.

	self assert: (shapes second outgoingLines collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingLines collect: #color) anyOne equals: Color gray.

	shapes second announce: RSMouseEnter.
	self assert: (shapes second outgoingLines collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingLines collect: #color) anyOne equals: Color red.

	shapes second announce: RSMouseLeave.
	self assert: (shapes second outgoingLines collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingLines collect: #color) anyOne equals: Color gray
]

{ #category : 'tests' }
RSHighlightableTest >> testWithEdges2 [
	| canvas shapes interaction |
	canvas := RSCanvas new.
	shapes := (1 to: 20) collect: [ :i |
		RSBox new
			size: 10;
			model: i;
			draggable;
			withBorder;
			yourself ].
	shapes := shapes asGroup.
	RSLineBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	canvas edges do: #withBorder.
	canvas addAll: shapes.
	RSClusterTreeLayout on: shapes.

	interaction := RSHighlightable withLines.
	shapes @ interaction.

	self assert: (shapes second outgoingLines collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingLines collect: #color) anyOne equals: Color gray.

	shapes second announce: RSMouseEnter.
	self assert: (shapes second outgoingLines collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingLines collect: #color) anyOne equals: Color black.

	shapes second announce: RSMouseLeave.
	self assert: (shapes second outgoingLines collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingLines collect: #color) anyOne equals: Color gray
]

{ #category : 'tests' }
RSHighlightableTest >> testWithOutgoingLines [
	| h c shapes |
	c := RSCanvas new.
	c addAll: (RSBox models: (1 to: 10)).
	RSLineBuilder line
		canvas: c;
		connectFrom: [ :n | n // 2 ].
	h := RSHighlightable new.
	h withOutgoingLines.
	c nodes @ h.
	shapes := h highlightShapesFor: c nodes first.
	self assert: shapes size equals: 2+2."the lines and the outgoing nodes"
	h withOutgoingLinesOnly.
	shapes := h highlightShapesFor: c nodes first.
	self assert: shapes size equals: 2.
	self assert: (shapes allSatisfy: [ :s | s isLine ]).

	h withOutgoingShapes.
	shapes := h highlightShapesFor: c nodes first.
	self assert: shapes size equals: 2.
	self assert: (shapes allSatisfy: [ :s | s isNode ])
]
