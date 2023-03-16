"
I can draw Forms
"
Class {
	#name : #RSBitmap,
	#superclass : #RSBoundingShape,
	#instVars : [
		'form'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #examples }
RSBitmap class >> example [
	| image |
	image := self new.
	image form: (self iconNamed: #pharo).
	image inspect
]

{ #category : #private }
RSBitmap >> computeRectangle [
	baseRectangle := Rectangle floatCenter: 0@0 extent: (form
		ifNil: [ 0@0 ]
		ifNotNil: [ form extent ]).
	encompassingRectangle := nil
]

{ #category : #accessing }
RSBitmap >> extent: newExtent [
	| oldExtent |
	oldExtent := self extent.
	(oldExtent = (0 @ 0)) ifTrue: [ ^ self ].
	matrix scaleBy: newExtent / oldExtent
]

{ #category : #accessing }
RSBitmap >> form [
	^ form
]

{ #category : #accessing }
RSBitmap >> form: aForm [
	aForm ifNil: [ ^ self ].
	form := aForm.
	self computeRectangle
]

{ #category : #accessing }
RSBitmap >> paintOn: visitor [
	^ visitor paintFor: self form: self form
]

{ #category : #visiting }
RSBitmap >> path [
	^ self baseRectangle
]
