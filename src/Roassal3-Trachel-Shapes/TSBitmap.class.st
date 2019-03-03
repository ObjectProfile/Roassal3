"
I can draw Forms
"
Class {
	#name : #TSBitmap,
	#superclass : #TSBoundingShape,
	#instVars : [
		'form'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #private }
TSBitmap >> computeRectangle [
	baseRectangle := form 
		ifNil: [ Rectangle center:0@0 extent: 0@0 ]
		ifNotNil: [ Rectangle center: 0@0 extent: form extent ]
]

{ #category : #accessing }
TSBitmap >> extent: newExtent [
	| oldExtent |
	oldExtent := self extent.
	(oldExtent = (0 @ 0)) ifTrue: [ ^ self ].
	matrix scaleBy: newExtent / oldExtent.

]

{ #category : #accessing }
TSBitmap >> form [
	^ form
]

{ #category : #accessing }
TSBitmap >> form: aForm [
	aForm ifNil: [ ^ self ].
	form := aForm.
	self computeRectangle.
]

{ #category : #accessing }
TSBitmap >> paintOn: visitor [
	^ visitor paintForBitmap: self
]

{ #category : #visiting }
TSBitmap >> path [
	^ baseRectangle
]

{ #category : #visiting }
TSBitmap >> pathFor: visitor [
	^ baseRectangle
]
