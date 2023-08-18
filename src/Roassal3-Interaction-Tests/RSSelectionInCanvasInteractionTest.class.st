Class {
	#name : #RSSelectionInCanvasInteractionTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas',
		'shapes'
	],
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #running }
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
			 shiftKeyPressed: true;
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
RSSelectionInCanvasInteractionTest >> testClickOnCanvasUnselectsAllShapes [

	canvas @ RSSelectionInCanvasInteraction.
	canvas setSelectedShapes: shapes.
	canvas leftClick.
	self assert: canvas selectedShapes isEmpty
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectAllShapesWithCommandA [

	canvas @ RSSelectionInCanvasInteraction.
	canvas announce: (RSKeyDown new
			 keyName: 'A';
			 commandKeyPressed: true;
			 controlKeyPressed: true;
			 yourself).
	self assert: canvas selectedShapes size equals: shapes size
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectNewAddedShapeWithShiftClick [

	| newShape |
	canvas @ RSSelectionInCanvasInteraction.
	newShape := RSBox model: 11.
	canvas add: newShape.
	newShape shiftLeftClick.
	self assert: newShape hasShadow
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectSeveralShapesWithShiftClick [

	| shapesToSelect |
	canvas @ RSSelectionInCanvasInteraction.
	shapesToSelect := canvas shapes copyFrom: 1 to: 5.
	shapesToSelect do: [ :shape | 
		shape shiftLeftClick ].
	self assert: (shapesToSelect allSatisfy: [ :s | s hasShadow ])
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectShapeWithShiftClick [

	canvas @ RSSelectionInCanvasInteraction.

	shapes first shiftLeftClick.
	self assert: shapes first hasShadow
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

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectShapesWhenThereAreAlreadySelectedShapes [

	| elasticBoxInteraction |
	canvas @ RSSelectionInCanvasInteraction.
	canvas setSelectedShapes: shapes.
	self assert: canvas selectedShapes size equals: shapes size.
	elasticBoxInteraction := canvas selectionInteraction elasticBoxInteraction.
	elasticBoxInteraction announce: (RSSelectionStartEvent new canvas: canvas).
	self assert: canvas selectedShapes isEmpty.
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectShapesWithModelOnlyUsingCommandA [

	canvas @ RSSelectionInCanvasInteraction withoutNilModels.
	shapes first model: nil.
	canvas announce: (RSKeyDown new
			 keyName: 'A';
			 commandKeyPressed: true;
			 controlKeyPressed: true;
			 yourself).
	self assert: canvas selectedShapes size equals: shapes size - 1
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testUnselectShapeWithShiftClick [

	
	canvas @ RSSelectionInCanvasInteraction.
	canvas setSelectedShapes: shapes.
	canvas shapes first shiftLeftClick.
	self deny: canvas shapes first hasShadow
]
