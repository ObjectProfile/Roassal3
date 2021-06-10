"
TODO
"
Class {
	#name : #RSMockShape,
	#superclass : #RSObject,
	#instVars : [
		'realElement',
		'position',
		'weight',
		'oldPosition',
		'isFixed',
		'fixPosition',
		'charge'
	],
	#category : #'Roassal3-Layouts-Utils'
}

{ #category : #actions }
RSMockShape >> addWeight [
	weight := weight + 1
]

{ #category : #actions }
RSMockShape >> applyToRealElement [
	isFixed ifTrue: [ ^ self ].
	realElement translateTo: position 
]

{ #category : #accessing }
RSMockShape >> canvas [
	^ realElement canvas
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
	^ realElement encompassingRectangle
]

{ #category : #accessing }
RSMockShape >> extent [
	^ realElement extent
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
	^ realElement height
]

{ #category : #actions }
RSMockShape >> initialize [
	super initialize.
	isFixed := false.
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
RSMockShape >> realElement [
	^ realElement
]

{ #category : #accessing }
RSMockShape >> realElement: rtElement [
	realElement := rtElement.
	position := rtElement position.
	self oldPosition: position.
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
	^ realElement width
]
