"
The RSMockShape class in Roassal is used for testing and mocking purposes. It provides a way to create mock shapes that can be used to test the behavior of other Roassal classes that depend on shapes.
"
Class {
	#name : #RSMockShape,
	#superclass : #RSObject,
	#instVars : [
		'position',
		'weight',
		'oldPosition',
		'isFixed',
		'fixPosition',
		'charge',
		'realShape',
		'width',
		'height'
	],
	#category : #'Roassal-Layouts-Util'
}

{ #category : #accessing }
RSMockShape class >> shapes: aCollection [
	^ aCollection collect: [ :shape | 
		self new 
			realShape: shape;
			yourself ]
]

{ #category : #actions }
RSMockShape >> addWeight [
	weight := weight + 1
]

{ #category : #actions }
RSMockShape >> applyToRealElement [
	isFixed ifTrue: [ ^ self ].
	realShape translateTo: position
]

{ #category : #accessing }
RSMockShape >> canvas [
	^ realShape canvas
]

{ #category : #accessing }
RSMockShape >> charge [
	^ charge
]

{ #category : #accessing }
RSMockShape >> charge: aNum [
	charge := aNum
]

{ #category : #accessing }
RSMockShape >> encompassingRectangle [
	^ Rectangle floatCenter: position extent: self extent
]

{ #category : #accessing }
RSMockShape >> extent [
	^ width @ height
]

{ #category : #accessing }
RSMockShape >> fixPosition [
	^ fixPosition
]

{ #category : #accessing }
RSMockShape >> fixPosition: aPoint [
	fixPosition := aPoint
]

{ #category : #accessing }
RSMockShape >> height [
	^ height
]

{ #category : #initialization }
RSMockShape >> initialize [
	super initialize.
	isFixed := false
]

{ #category : #accessing }
RSMockShape >> isFixed [
	^ isFixed
]

{ #category : #accessing }
RSMockShape >> isFixed: aBool [
	isFixed := aBool
]

{ #category : #accessing }
RSMockShape >> oldPosition [
	^ oldPosition
]

{ #category : #accessing }
RSMockShape >> oldPosition: aPoint [
	oldPosition := aPoint
]

{ #category : #accessing }
RSMockShape >> position [
	^ position
]

{ #category : #accessing }
RSMockShape >> realShape [
	^ realShape
]

{ #category : #accessing }
RSMockShape >> realShape: aRSShape [
	| extent |
	extent := aRSShape extent.
	realShape := aRSShape.
	position := aRSShape position.
	width := extent x.
	height := extent y.
	self oldPosition: position
]

{ #category : #accessing }
RSMockShape >> textExtents [
	^ realShape textExtents
]

{ #category : #actions }
RSMockShape >> translateTo: aPosition [
	position := aPosition
]

{ #category : #accessing }
RSMockShape >> weight [
	^ weight
]

{ #category : #accessing }
RSMockShape >> weight: aNumber [
	weight := aNumber
]

{ #category : #accessing }
RSMockShape >> width [
	^ width
]
