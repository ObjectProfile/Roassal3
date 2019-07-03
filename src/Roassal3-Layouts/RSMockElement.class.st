"
TODO
"
Class {
	#name : #RSMockElement,
	#superclass : #RSObject,
	#instVars : [
		'realElement',
		'position'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #action }
RSMockElement >> applyToRealElement [
	realElement translateTo: position
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
RSMockElement >> height [
	^ realElement height
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
	position := rtElement position
]

{ #category : #actions }
RSMockElement >> translateTo: aPosition [
	position := aPosition
]

{ #category : #accessing }
RSMockElement >> view [
	^ realElement view
]

{ #category : #accessing }
RSMockElement >> width [
	^ realElement width
]
