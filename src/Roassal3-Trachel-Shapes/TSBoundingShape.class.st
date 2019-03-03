"
My subclasses has an extent
"
Class {
	#name : #TSBoundingShape,
	#superclass : #TSShape,
	#instVars : [
		'baseRectangle'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSBoundingShape >> accept: visitor [
	visitor visitBoundingShape: self
]

{ #category : #accessing }
TSBoundingShape >> baseRectangle [
	^ baseRectangle
]

{ #category : #accessing }
TSBoundingShape >> encompassingRectangle [ 
	^ Rectangle center: self position extent: baseRectangle extent.
]

{ #category : #accessing }
TSBoundingShape >> extent [
	^ baseRectangle extent
]

{ #category : #accessing }
TSBoundingShape >> extent: aPoint [
	baseRectangle := Rectangle center: 0@0 extent: aPoint.
	self resetPath
]

{ #category : #accessing }
TSBoundingShape >> height: aNumber [
	self extent: self extent x @ aNumber
]

{ #category : #testing }
TSBoundingShape >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	^ baseRectangle containsPoint: invertedPoint.
]

{ #category : #initialization }
TSBoundingShape >> initialize [
	super initialize.
	baseRectangle := (0 @ 0) extent: (0 @ 0).
]

{ #category : #accessing }
TSBoundingShape >> paintOn: visitor [
	^ paint
	
	
]

{ #category : #accessing }
TSBoundingShape >> size: anInteger [
	self extent: anInteger asPoint
]

{ #category : #accessing }
TSBoundingShape >> width: aNumber [
	self extent: aNumber @ self extent y
]
