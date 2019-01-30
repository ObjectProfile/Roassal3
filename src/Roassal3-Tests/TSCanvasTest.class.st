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
	c morph drawOnMockCanvas.
]

{ #category : #running }
TSCanvasTest >> testEmpty [
	self assert: c numberOfShapes equals: 0
]

{ #category : #running }
TSCanvasTest >> testOpening [
	c open delete
]
