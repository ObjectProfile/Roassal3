"
TODO
"
Class {
	#name : #TSMockElement,
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
TSMockElement >> addWeight [
	weight := weight + 1
]

{ #category : #actions }
TSMockElement >> applyToRealElement [
	isFixed ifTrue: [ ^ self ].
	realElement translateTo: position 
]

{ #category : #accessing }
TSMockElement >> canvas [
	^ realElement canvas
]

{ #category : #accessing }
TSMockElement >> charge [
	^ charge
]

{ #category : #accessing }
TSMockElement >> charge: aNum [
	charge := aNum
]

{ #category : #accessing }
TSMockElement >> encompassingRectangle [ 
	^ realElement encompassingRectangle
]

{ #category : #accessing }
TSMockElement >> extent [
	^ realElement extent
]

{ #category : #accessing }
TSMockElement >> fixPosition [
	^ fixPosition
]

{ #category : #accessing }
TSMockElement >> fixPosition: aPoint [
	fixPosition := aPoint
]

{ #category : #accessing }
TSMockElement >> height [
	^ realElement height
]

{ #category : #actions }
TSMockElement >> initialize [
	super initialize.
	isFixed := false.
]

{ #category : #accessing }
TSMockElement >> isFixed [
	^ isFixed 
]

{ #category : #accessing }
TSMockElement >> isFixed: aBool [
	isFixed := aBool
]

{ #category : #accessing }
TSMockElement >> oldPosition [
	^ oldPosition
]

{ #category : #accessing }
TSMockElement >> oldPosition: aPoint [
	oldPosition := aPoint
]

{ #category : #accessing }
TSMockElement >> position [
	^ position
]

{ #category : #accessing }
TSMockElement >> realElement [
	^ realElement
]

{ #category : #accessing }
TSMockElement >> realElement: rtElement [
	realElement := rtElement.
	position := rtElement position.
	self oldPosition: position.
]

{ #category : #actions }
TSMockElement >> translateTo: aPosition [
	position := aPosition
]

{ #category : #accessing }
TSMockElement >> weight [
	^ weight
]

{ #category : #accessing }
TSMockElement >> weight: aNumber [
	weight := aNumber
]

{ #category : #accessing }
TSMockElement >> width [
	^ realElement width
]
