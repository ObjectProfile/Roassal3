"
I have common tests for shapes and canvas
"
Class {
	#name : #TSCanvasTest,
	#superclass : #TSTest,
	#instVars : [
		'c'
	],
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #running }
TSCanvasTest >> setUp [
	super setUp.
	c := TSCanvas new
]

{ #category : #running }
TSCanvasTest >> testAddOneShape [

	c addShape: TSBox new.
	self assert: c numberOfShapes equals: 1.
	self assert: c numberOfFixedShapes equals: 0
]

{ #category : #running }
TSCanvasTest >> testDrawCanvas [
	c addShape: (TSBox new
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		position: 100@100;
		extent: 100@100;
		yourself).
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testDrawCanvasWithGroup [
	| g |
	g := TSComposite new.
	g add: (TSBox new
		extent: 100@100;
		yourself).
	g add: (TSEllipse new
		position: 100@100;
		extent: 100@100;
		yourself).
	c addShape: g.
	c createMorph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testDrawFixed [
	| box |
	box := TSBox new
		extent: 100@100;
		yourself.
	box isFixed: true.
	c addShape: box.
	
	box := TSBox new
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

{ #category : #running }
TSCanvasTest >> testEmpty [
	self assert: c numberOfShapes equals: 0
]

{ #category : #events }
TSCanvasTest >> testEvent [ 
	| box |
	box := TSBox new.
	box when: TSMouseClick do: [ :evt |  ]
]

{ #category : #events }
TSCanvasTest >> testLowLevelEvent [

	| box |
	box := TSBox new size: 30.
	box when: TSMouseDragging do: [ :evt | box  ].
	c addShape: box.

	self assert: (c shapeWithAction: TSMouseDragging forPositionInPixels: 250 @ 250) == box
]

{ #category : #running }
TSCanvasTest >> testOpening [
	c open delete
]

{ #category : #tests }
TSCanvasTest >> testRemovingShapes [
	| e |
	e := TSEllipse new.
	c addShape: e.
	self assert: c shapes size equals: 1.
	e remove.
	self assert: c shapes size equals: 0.
]
