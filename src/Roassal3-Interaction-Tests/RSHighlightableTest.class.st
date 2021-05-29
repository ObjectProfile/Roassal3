Class {
	#name : #RSHighlightableTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #tests }
RSHighlightableTest >> testBasic [

	| c shapes previousColor |
	c := RSCanvas new.
	shapes := (1 to: 10) collect: [ :n | RSEllipse new size: 20; model: n ] as: RSGroup.
	c addAll: shapes.
	RSGridLayout on: shapes.

	previousColor := shapes fifth color.
	RSHighlightableInteraction new doHighlight: shapes fifth.
	self assert: shapes fifth color equals: previousColor.
	
	RSHighlightableInteraction new record: shapes fifth selector: #color value: Color blue.
	self assert: shapes fifth color equals: Color blue.
	
	RSHighlightableInteraction new restore: shapes fifth selector: #color.
	self assert: shapes fifth color equals: previousColor.
]

{ #category : #tests }
RSHighlightableTest >> testSameModel [

	| values c boxes |
	values := #(1 1 2 2 2 2 3 3 3 4 4 5 5 5 5 ).

	c := RSCanvas new.
	boxes := values collect: [ :vv | RSBox new size: 10; model: vv ] as: RSGroup.
	c addAll: boxes.
	boxes @ RSPopup.
	boxes @ (RSHighlightableInteraction sameModel: c).
	RSGridLayout on: boxes.
	c @ RSCanvasController.
	
	c nodes first announce: RSMouseEnter
]

{ #category : #tests }
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
	RSClusterLayout on: shapes.
	
	interaction := RSHighlightableInteraction red.
	interaction withLines.
	shapes @ interaction.
	
	self assert: (shapes second outgoingEdges collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingEdges collect: #color) anyOne equals: Color gray.
	
	shapes second announce: RSMouseEnter.
	self assert: (shapes second outgoingEdges collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingEdges collect: #color) anyOne equals: Color red.
	
	shapes second announce: RSMouseLeave.
	self assert: (shapes second outgoingEdges collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingEdges collect: #color) anyOne equals: Color gray.


]

{ #category : #tests }
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
	RSClusterLayout on: shapes.
	
	interaction := RSHighlightableInteraction withLines.
	shapes @ interaction.
	
	self assert: (shapes second outgoingEdges collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingEdges collect: #color) anyOne equals: Color gray.
	
	shapes second announce: RSMouseEnter.
	self assert: (shapes second outgoingEdges collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingEdges collect: #color) anyOne equals: Color black.
	
	shapes second announce: RSMouseLeave.
	self assert: (shapes second outgoingEdges collect: #color) asSet size equals: 1.
	self assert: (shapes second outgoingEdges collect: #color) anyOne equals: Color gray.

	
]
