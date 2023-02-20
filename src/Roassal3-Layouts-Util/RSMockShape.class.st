"
TODO
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
		'realShape'
	],
	#category : #'Roassal3-Layouts-Util'
}

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
	^ realShape encompassingRectangle
]

{ #category : #accessing }
RSMockShape >> extent [
	^ realShape extent
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
	^ realShape height
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
RSMockShape >> realShape: rtElement [
	realShape := rtElement.
	position := rtElement position.
	self oldPosition: position
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
	^ realShape width
]
