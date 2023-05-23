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
RSSelectionInCanvasInteractionTest >> testSelectShapes [

	self assert: canvas selectedShapes isEmpty.
	canvas selectedShapes: shapes.
	self assert: canvas selectedShapes size equals: shapes size
]

{ #category : #tests }
RSSelectionInCanvasInteractionTest >> testSelectShapesHaveShadow [
	self skip.
	canvas setSelectedShapes: shapes.
	self assert: canvas selectedShapes size equals: shapes size.
	self assert: (shapes allSatisfy: [ :each | each hasShadow not ]).
	
	canvas @ RSSelectionInCanvasInteraction.	
	canvas setSelectedShapes: shapes.
	self assert: (shapes allSatisfy: [ :each | each hasShadow ]).
]
