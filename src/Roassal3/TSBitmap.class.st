"
I can draw Forms
"
Class {
	#name : #TSBitmap,
	#superclass : #TSBoundingShape,
	#instVars : [
		'form'
	],
	#category : #'Roassal3-Shape'
}

{ #category : #private }
TSBitmap >> computeRectangle [
	baseRectangle := Rectangle rsCenter: 0@0 extent: (form 
		ifNil: [ 0@0 ]
		ifNotNil: [ form extent ])
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
	^ visitor paintFor: self form: self form
]

{ #category : #visiting }
TSBitmap >> path [
	^ self baseRectangle
]
