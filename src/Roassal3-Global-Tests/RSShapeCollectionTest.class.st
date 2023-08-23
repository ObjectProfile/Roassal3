Class {
	#name : #RSShapeCollectionTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Rendering'
}

{ #category : #'tests - adding' }
RSShapeCollectionTest >> testAdd [
	| canvas collection |
	canvas := RSCanvas new.
	collection := canvas shapeCollection.
	canvas add: RSBox new.
	self assert: canvas shapes size equals: 1.
	self assert: canvas nodes size equals: 1.
	self assert: canvas lines size equals: 0.
	self assert: canvas fixedShapes size equals: 0.
	self assert: canvas shapeCollection size equals: 1.
	
	canvas add: RSLine new.
	self assert: canvas shapes size equals: 2.
	self assert: canvas nodes size equals: 1.
	self assert: canvas lines size equals: 1.
	self assert: canvas fixedShapes size equals: 0.
	self assert: canvas shapeCollection size equals: 2.
	
	canvas add: (RSBox new isFixed: true).
	self assert: canvas shapes size equals: 2.
	self assert: canvas nodes size equals: 2.
	self assert: canvas lines size equals: 1.
	self assert: canvas fixedShapes size equals: 1.
	self assert: canvas shapeCollection size equals: 2.
	
	canvas addShape: RSBox new.
	self assert: canvas shapes size equals: 3.
	self assert: canvas nodes size equals: 2.
	self assert: canvas lines size equals: 1.
	self assert: canvas fixedShapes size equals: 1.
	self assert: canvas shapeCollection size equals: 3.
]

{ #category : #tests }
RSShapeCollectionTest >> testBasic [
	| canvas collection |
	canvas := RSCanvas new.
	collection := canvas shapeCollection.
	self assert: collection class equals: canvas defaultShapeCollection class.
	self assert: collection isCollection.
	self assert: collection isEmpty.
	
]

{ #category : #tests }
RSShapeCollectionTest >> testContainsPoint [
	| canvas collection box shape position |
	canvas := RSCanvas new.
	position := 1000 asPoint.
	box := RSBox new
		size: 100 asPoint;
		position: position;
		yourself.
	collection := canvas shapeCollection.
	canvas add: box.
	self assert: collection notEmpty.
	shape := canvas shapeWithActionForPosition: position.
	self assert: shape isNil.
	shape := collection shapeAtPoint: position.
	self assert: shape equals: box.
	box @ RSDraggable.
	shape := canvas shapeWithActionForPosition: position.
	self assert: shape equals: box
]

{ #category : #tests }
RSShapeCollectionTest >> testContainsPointInComposite [
	| canvas collection box shapes position composite |
	canvas := RSCanvas new.
	position := 1000 asPoint.
	box := RSBox new
		size: 100;
		position: position;
		yourself.
	composite := { box } asShape size: 200.
	composite draggable.
	collection := canvas shapeCollection.
	canvas add: composite.
	
	shapes := canvas shapesWithActionForPosition: position.
	self assert: shapes size equals: 1.
	self assert: shapes first equals: composite.
	shapes := collection shapesAtPoint: position.
	self assert: shapes size equals: 2.
]

{ #category : #tests }
RSShapeCollectionTest >> testContainsPointInRTree [
	| canvas collection box shape position |
	canvas := RSCanvas new.
	canvas useRTree.
	position := 1000 asPoint.
	box := RSBox new
		size: 100 asPoint;
		position: position;
		yourself.
	collection := canvas shapeCollection.
	canvas add: box.
	self assert: collection notEmpty.
	shape := canvas shapeWithActionForPosition: position.
	self assert: shape isNil.
	shape := collection shapeAtPoint: position.
	self assert: shape equals: box.
	box @ RSDraggable.
	shape := canvas shapeWithActionForPosition: position.
	self assert: shape equals: box
]

{ #category : #'tests - removing' }
RSShapeCollectionTest >> testRemoveOneElement [
	| canvas collection box |
	canvas := RSCanvas new.
	collection := canvas shapeCollection.
	box := RSBox new.
	canvas add: box.
	box remove.
	self assert: canvas shapes isEmpty.
	self assert: collection isEmpty.
]

{ #category : #'tests - removing' }
RSShapeCollectionTest >> testUpdateExtentShouldUpdateTreeRectangle [
	| canvas collection box oldExtent newExtent |
	canvas := RSCanvas new.
	canvas useRTree.
	collection := canvas shapeCollection.
	oldExtent := 10@10.
	newExtent := 20@20.
	box := RSBox new.
	box extent: oldExtent.
	canvas add: box.
	
	self assert: collection root rectangle equals: box encompassingRectangle.
	box extent: newExtent.
	self assert: box encompassingRectangle extent equals: newExtent.
	self assert: collection root rectangle equals: box encompassingRectangle.
	
]
