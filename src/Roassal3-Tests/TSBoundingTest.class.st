"
Test for all shapes with a matrix an one encompassing rectangle
"
Class {
	#name : #TSBoundingTest,
	#superclass : #TSCanvasTest,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #running }
TSBoundingTest >> testDrawBitamp [
	c addShape: (TSBitmap new
		form: (ColorForm extent: 100@100 depth: 32)). 
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSBoundingTest >> testDrawBorder [
	c addShape: (TSEllipse new
		radius: 100;
		border: TSBorder new;
		yourself).
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSBoundingTest >> testDrawBoxCornerRadius [
	c addShape: (TSBox new
		extent: 100@100;
		cornerRadius: 5;
		yourself).
	c morph drawOnMockCanvas.
]

{ #category : #tests }
TSBoundingTest >> testPosition [
	| b |
	b := TSBox new.
	self assert: b position equals: 0@0.
	b position: 0@0.
]
