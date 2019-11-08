"
TODO
"
Class {
	#name : #RSMockElement,
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
RSMockElement >> addWeight [
	weight := weight + 1
]

{ #category : #actions }
RSMockElement >> applyToRealElement [
	isFixed ifTrue: [ ^ self ].
	realElement translateTo: position 
]

{ #category : #accessing }
RSMockElement >> canvas [
	^ realElement canvas
]

{ #category : #accessing }
RSMockElement >> charge [
	^ charge
]

{ #category : #accessing }
RSMockElement >> charge: aNum [
	charge := aNum
]

{ #category : #accessing }
RSMockElement >> encompassingRectangle [ 
	^ realElement encompassingRectangle
]

{ #category : #accessing }
RSMockElement >> extent [
	^ realElement extent
]

{ #category : #accessing }
RSMockElement >> fixPosition [
	^ fixPosition
]

{ #category : #accessing }
RSMockElement >> fixPosition: aPoint [
	fixPosition := aPoint
]

{ #category : #accessing }
RSMockElement >> height [
	^ realElement height
]

{ #category : #actions }
RSMockElement >> initialize [
	super initialize.
	isFixed := false.
]

{ #category : #accessing }
RSMockElement >> isFixed [
	^ isFixed 
]

{ #category : #accessing }
RSMockElement >> isFixed: aBool [
	isFixed := aBool
]

{ #category : #accessing }
RSMockElement >> oldPosition [
	^ oldPosition
]

{ #category : #accessing }
RSMockElement >> oldPosition: aPoint [
	oldPosition := aPoint
]

{ #category : #accessing }
RSMockElement >> position [
	^ position
]

{ #category : #accessing }
RSMockElement >> realElement [
	^ realElement
]

{ #category : #accessing }
RSMockElement >> realElement: rtElement [
	realElement := rtElement.
	position := rtElement position.
	self oldPosition: position.
]

{ #category : #actions }
RSMockElement >> translateTo: aPosition [
	position := aPosition
]

{ #category : #accessing }
RSMockElement >> weight [
	^ weight
]

{ #category : #accessing }
RSMockElement >> weight: aNumber [
	weight := aNumber
]

{ #category : #accessing }
RSMockElement >> width [
	^ realElement width
]
