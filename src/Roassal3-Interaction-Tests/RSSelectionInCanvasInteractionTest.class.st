Class {
	#name : #RSSelectionInCanvasInteractionTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas',
		'shapes'
	],
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> setUp [

	super setUp.
	canvas := RSCanvas new.
	shapes := RSBox models: (1 to: 10).
	canvas addAll: shapes
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testAnnounceWhenSelectionStart [

	| selectionFrom |
	selectionFrom := nil.
	canvas @ RSSelectionInCanvasInteraction.

	canvas
		when: RSSelectionStartEvent
		do: [ :evt | selectionFrom := evt selectedShapes ]
		for: self.
	canvas announce: (RSMouseLeftDragStart new
			 position: 0 asPoint;
			 yourself).
	self assert: selectionFrom notNil
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testAnnounceWhenShapesAreSelected [

	| selectionFrom |
	selectionFrom := nil.
	canvas @ RSSelectionInCanvasInteraction.

	canvas
		when: RSSelectionChangedEvent
		do: [ :evt | selectionFrom := evt selectedShapes ]
		for: self.
	canvas setSelectedShapes: shapes.
	self assert: selectionFrom notNil
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectShapes [

	self assert: canvas selectedShapes isEmpty.
	canvas selectedShapes: shapes.
	self assert: canvas selectedShapes size equals: shapes size
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectShapesHaveShadow [

	self should: [ canvas setSelectedShapes: shapes ] raise: Exception.
	self assert: (shapes allSatisfy: [ :each | each shadow isNil ]).

	canvas @ RSSelectionInCanvasInteraction.
	canvas setSelectedShapes: shapes.
	self assert: (shapes allSatisfy: [ :each | each shadow notNil ])
]
