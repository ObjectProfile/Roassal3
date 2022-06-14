"
RSAbstractRenderTree defines 2 methods to search shapes.

`shapeWithAction: eventClass forPositionInPixels: position`

`shapeWithActionForPositionInPixels: position`

subclasses of this tree should override Collection abstract methods
"
Class {
	#name : #RSShapeCollection,
	#superclass : #Collection,
	#category : #'Roassal3-Rendering'
}

{ #category : #adding }
RSShapeCollection >> bulkLoad: aCollectionOfShapes [
	self addAll: aCollectionOfShapes
]

{ #category : #'finding/searching' }
RSShapeCollection >> shapesAtPoint: position [
	
	^ self subclassResponsibility
	
]

{ #category : #'finding/searching' }
RSShapeCollection >> shapesAtRectangle: aRectangle [
	^ self subclassResponsibility
]
