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
TSCanvasTest >> testDrawBezierLine [
	c addShape: (TSBezier new
		strokeColor: Color red;
		width: 2). 
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testDrawBitamp [
	c addShape: (TSBitmap new
		form: (ColorForm extent: 100@100 depth: 32)). 
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testDrawBorder [
	c addShape: (TSEllipse new
		radius: 100;
		border: TSBorder new;
		yourself).
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testDrawBoxCornerRadius [
	c addShape: (TSBox new
		extent: 100@100;
		cornerRadius: 5;
		yourself).
	c morph drawOnMockCanvas.
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
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testDrawCanvasWithGroup [
	| g |
	g := TSGroup new.
	g addShape: (TSBox new
		extent: 100@100;
		yourself).
	g addShape: (TSEllipse new
		position: 100@100;
		extent: 100@100;
		yourself).
	c addShape: g.
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testDrawLine [
	c addShape: (TSLine new
		strokeColor: Color red;
		width: 2). 
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testDrawSVGLine [
	c addShape: (TSSVGPathLine new
		strokeColor: Color red;
		svgPath: [ :a :b | 'M 100 100 L 200 200' ];
		width: 2). 
	c addShape: (TSSVGPathLine new
		strokeColor: Color red;
		svgPath: [:a :b | String streamContents: [:stream |
			stream 
				nextPutAll: 'M ';
				nextPutAll: a x asString;
				space;
				nextPutAll: a y asString;
				space;
				nextPutAll: 'L ';
				nextPutAll: b x asString;
				space;
				nextPutAll: b y asString.
		] ];
		startPoint: 100@100;
		endPoint: 200@200;
		width: 2). 
	c addShape: (TSSVGPathLine new
		strokeColor: Color red;
		svgPath: [ :a :b | [ :canvas| 
			canvas
				absolute;
				moveTo: a;
				lineTo: b. ] ];
		width: 2). 
	c morph drawOnMockCanvas.
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
TSCanvasTest >> testPosition [
	| b |
	b := TSBox new.
	self assert: b position equals: 0@0.
	b position: 0@0.
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
