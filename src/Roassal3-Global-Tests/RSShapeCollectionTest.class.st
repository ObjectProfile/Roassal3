Class {
	#name : #RSShapeCollectionTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Rendering'
}

{ #category : #tests }
RSShapeCollectionTest >> testBasic [
	| canvas collection |
	canvas := RSCanvas new.
	collection := canvas shapeCollection.
	self assert: collection class equals: canvas defaultShapeCollection class.
	self assert: collection isCollection.
	self assert: collection isEmpty
]

{ #category : #tests }
RSShapeCollectionTest >> testContainsPoint [
	| canvas collection box shape |
	self skip.
	canvas := RSCanvas new.
	box := RSBox new
		size: 100 asPoint;
		position: 1000 asPoint;
		yourself.
	collection := canvas shapeCollection.
	canvas add: box.
	self assert: collection notEmpty.
	shape := canvas shapeWithActionForPosition: 1000 asPoint.
	self assert: shape isNil.
	shape := collection shapeAtPoint: 1000 asPoint.
	self assert: shape equals: box.
	shape @ RSDraggable.
	shape := canvas shapeWithActionForPosition: 1000 asPoint.
	self assert: shape equals: box
]
