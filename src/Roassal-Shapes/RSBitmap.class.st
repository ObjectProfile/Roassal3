"
I can draw Forms
"
Class {
	#name : 'RSBitmap',
	#superclass : 'RSBoundingShape',
	#instVars : [
		'form'
	],
	#category : 'Roassal-Shapes-Bounding',
	#package : 'Roassal-Shapes',
	#tag : 'Bounding'
}

{ #category : 'instance creation' }
RSBitmap class >> newFrom: anObject [
	| shape |
	shape := self new.
	shape form: (anObject isString
		ifTrue: [ (self iconNamed: anObject) ]
		ifFalse: [anObject ]).
	^ shape
]

{ #category : 'private' }
RSBitmap >> computeRectangle [
	baseRectangle := Rectangle floatCenter: 0@0 extent: (form
		ifNil: [ 0@0 ]
		ifNotNil: [ form extent ]).
	encompassingRectangle := nil
]

{ #category : 'accessing' }
RSBitmap >> extent: newExtent [
	| oldExtent |
	oldExtent := self extent.
	(oldExtent = (0 @ 0)) ifTrue: [ ^ self ].
	matrix scaleBy: newExtent / oldExtent.
	self resetBBox
]

{ #category : 'accessing' }
RSBitmap >> form [
	^ form
]

{ #category : 'accessing' }
RSBitmap >> form: aForm [
	aForm ifNil: [ ^ self ].
	form := aForm.
	self computeRectangle
]

{ #category : 'accessing' }
RSBitmap >> paintOn: visitor [
	^ visitor paintFor: self form: self form
]

{ #category : 'visiting' }
RSBitmap >> path [
	^ self baseRectangle
]
