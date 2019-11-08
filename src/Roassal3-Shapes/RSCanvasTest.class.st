"
I have common tests for shapes and canvas
"
Class {
	#name : #RSCanvasTest,
	#superclass : #RSTest,
	#instVars : [
		'c'
	],
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #running }
RSCanvasTest >> setUp [
	super setUp.
	c := RSCanvas new
]

{ #category : #running }
RSCanvasTest >> testAddOneShape [

	c addShape: RSBox new.
	self assert: c numberOfShapes equals: 1.
	self assert: c numberOfFixedShapes equals: 0
]

{ #category : #running }
RSCanvasTest >> testDrawCanvas [
	c addShape: (RSBox new
		extent: 100@100;
		yourself).
	c addShape: (RSEllipse new
		position: 100@100;
		extent: 100@100;
		yourself).
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSCanvasTest >> testDrawCanvasWithGroup [
	| g |
	g := RSComposite new.
	g add: (RSBox new
		extent: 100@100;
		yourself).
	g add: (RSEllipse new
		position: 100@100;
		extent: 100@100;
		yourself).
	c addShape: g.
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
RSCanvasTest >> testDrawFixed [
	| box |
	box := RSBox new
		extent: 100@100;
		yourself.
	box isFixed: true.
	c addShape: box.
	
	box := RSBox new
		extent: 100@100;
		yourself.
	c addShape: box.
	self deny: box isFixed.
	box setAsFixed.
	self assert: box isFixed.
	self assert: c numberOfShapes equals: 0.
	self assert: c numberOfFixedShapes equals: 2.
	c createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSCanvasTest >> testElementFromModel [
	| shapes |
	shapes := (1 to: 3) collect: [ :m | RSBox new model: m; yourself ].
	c addAll: shapes.
	
	self assert: (c shapeFromModel: 1) == shapes first.
	self assert: (c shapeFromModel: 2) == shapes second.
	self assert: (c shapeFromModel: 3) == shapes third.
]

{ #category : #running }
RSCanvasTest >> testEmpty [
	self assert: c numberOfShapes equals: 0
]

{ #category : #events }
RSCanvasTest >> testEvent [ 
	| box |
	box := RSBox new.
	box when: RSMouseClick do: [ :evt |  ]
]

{ #category : #events }
RSCanvasTest >> testLowLevelEvent [

	| box |
	box := RSBox new size: 30.
	box when: RSMouseDragging do: [ :evt | box  ].
	c addShape: box.

	self assert: (c shapeWithAction: RSMouseDragging forPositionInPixels: 250 @ 250) == box
]

{ #category : #tests }
RSCanvasTest >> testNestedShape [

	| shape innerShape |
	shape := RSComposite new.
	c addShape: shape.
	innerShape := RSBox new.
	shape add: innerShape.
	
	self assert: shape canvas equals: c.
	self assert: innerShape parent equals: shape.
	self assert: innerShape canvas equals: c.
	
]

{ #category : #tests }
RSCanvasTest >> testNestedShapeNotAddedToACanvas [

	| shape innerShape |
	shape := RSComposite new.
	innerShape := RSBox new.
	shape add: innerShape.
	
	self assert: shape canvas isNil.
	self assert: innerShape parent equals: shape.
	self assert: innerShape canvas isNil.
	
]

{ #category : #running }
RSCanvasTest >> testOpening [
	c open delete
]

{ #category : #tests }
RSCanvasTest >> testRemovingShapes [
	| e |
	e := RSEllipse new.
	c addShape: e.
	self assert: c shapes size equals: 1.
	e remove.
	self assert: c shapes size equals: 0.
]
