"
RSAbstractRenderTree defines 2 methods to search shapes.

- `shapeAtPoint:`
- `shapesAtRectangle:`
- `bulkload:` when user is going to change the `shapesCollection:` in canvas

subclasses of this tree should override also Collection abstract methods
"
Class {
	#name : #RSShapeCollection,
	#superclass : #Collection,
	#category : #'Roassal3-Rendering'
}

{ #category : #adding }
RSShapeCollection >> add: aShape before: otherShape [
	^ self subclassResponsibility
]

{ #category : #adding }
RSShapeCollection >> bulkLoad: aCollectionOfShapes [
	self addAll: aCollectionOfShapes
]

{ #category : #'shapes - ordering' }
RSShapeCollection >> pushBack: aShape [
	self subclassResponsibility
]

{ #category : #'shapes - ordering' }
RSShapeCollection >> pushFront: aShape [
	self subclassResponsibility
]

{ #category : #'finding/searching' }
RSShapeCollection >> shapeAtPoint: aPoint [
	| result |
	result := self shapesAtPoint: aPoint.
	result ifEmpty: [ ^ nil ].
	^ result anyOne
]

{ #category : #'finding/searching' }
RSShapeCollection >> shapesAtPoint: position [

	^ self subclassResponsibility
]

{ #category : #'finding/searching' }
RSShapeCollection >> shapesAtRectangle: aRectangle [
	^ self subclassResponsibility
]

{ #category : #'finding/searching' }
RSShapeCollection >> updateShape: aShape [
	^ self subclassResponsibility
]
