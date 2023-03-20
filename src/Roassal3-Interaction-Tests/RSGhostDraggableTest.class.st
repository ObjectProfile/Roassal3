"
A RSGhostDraggableTest is a test class for testing the behavior of RSGhostDraggable
"
Class {
	#name : #RSGhostDraggableTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #tests }
RSGhostDraggableTest >> testBasic [
	| shape interaction c |
	c := RSCanvas new.

	shape := RSShapeFactory star
		size: 10;
		yourself.
	c add: shape.
	interaction := RSGhostDraggable new.

	shape @ interaction.
	self assert: (shape propertyAt: #ghost) isNil.
	shape announce: RSMouseDragStart new.
	self assert: (shape propertyAt: #ghost) notNil.
	self assert: (shape propertyAt: #ghost) class equals: RSPolygon.
	shape announce: RSMouseDragEnd new.
	self assert: (shape propertyAt: #ghost) isNil
]

{ #category : #tests }
RSGhostDraggableTest >> testComposite [
	| shape interaction c |
	c := RSCanvas new.

	shape := RSComposite new
		children: (RSBox
			models: Collection withAllSubclasses
			forEach: [ :s :cls|
				s size: 10.
			 ]);
		adjustToChildren;
		yourself.
	c add: shape.
	interaction := RSGhostDraggable new.

	shape @ interaction.
	shape announce: RSMouseDragStart new.
	self assert: (shape propertyAt: #ghost) notNil.
	self assert: (shape propertyAt: #ghost) class equals: RSComposite.
	self assert: (shape propertyAt: #ghost) privateShapes isNil.
	shape announce: RSMouseDragEnd new.
	self assert: (shape propertyAt: #ghost) isNil
]
