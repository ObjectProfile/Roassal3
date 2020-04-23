"
I have common tests for shapes and canvas
"
Class {
	#name : #RSCanvasTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #running }
RSCanvasTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]

{ #category : #running }
RSCanvasTest >> testAddOneShape [

	canvas addShape: RSBox new.
	self assert: canvas numberOfShapes equals: 1.
	self assert: canvas numberOfFixedShapes equals: 0
]

{ #category : #running }
RSCanvasTest >> testDrawCanvas [
	canvas addShape: (RSBox new
		extent: 100@100;
		yourself).
	canvas addShape: (RSEllipse new
		position: 100@100;
		extent: 100@100;
		yourself).
	canvas createMorph drawOnMockCanvas.
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
	canvas addShape: g.
	canvas createMorph drawOnMockCanvas.
]

{ #category : #running }
RSCanvasTest >> testDrawFixed [
	| box |
	box := RSBox new
		extent: 100@100;
		yourself.
	box isFixed: true.
	canvas addShape: box.
	
	box := RSBox new
		extent: 100@100;
		yourself.
	canvas addShape: box.
	self deny: box isFixed.
	box setAsFixed.
	self assert: box isFixed.
	self assert: canvas numberOfShapes equals: 0.
	self assert: canvas numberOfFixedShapes equals: 2.
	canvas createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSCanvasTest >> testElementFromModel [
	| shapes |
	shapes := (1 to: 3) collect: [ :m | RSBox new model: m; yourself ].
	canvas addAll: shapes.
	
	self assert: (canvas shapeFromModel: 1) equals: shapes first.
	self assert: (canvas shapeFromModel: 2) equals: shapes second.
	self assert: (canvas shapeFromModel: 3) equals: shapes third.
	self assert: (canvas shapeFromModel: 4) isNil
]

{ #category : #running }
RSCanvasTest >> testEmpty [
	self assert: canvas numberOfShapes equals: 0
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
	box when: RSMouseDragging do: [ :evt | box ].
	canvas addShape: box.
	self assert: canvas extent equals: 500 asPoint.
	self
		assert: (canvas shapeWithAction: RSMouseDragging forPositionInPixels: 250 @ 250)
		identicalTo: box
]

{ #category : #tests }
RSCanvasTest >> testNestedShape [

	| shape innerShape |
	shape := RSComposite new.
	canvas addShape: shape.
	innerShape := RSBox new.
	shape add: innerShape.
	
	self assert: shape canvas equals: canvas.
	self assert: innerShape parent equals: shape.
	self assert: innerShape canvas equals: canvas.
	
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
	canvas open delete
]

{ #category : #tests }
RSCanvasTest >> testRemovingShapes [
	| e |
	e := RSEllipse new.
	canvas addShape: e.
	self assert: canvas shapes size equals: 1.
	e remove.
	self assert: canvas shapes size equals: 0.
]
