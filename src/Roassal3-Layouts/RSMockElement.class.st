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

{ #category : #'as yet unclassified' }
RSMockElement >> extent [
	^ realElement extent
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
RSMockElement >> view [
	^ realElement view
]

{ #category : #'as yet unclassified' }
RSMockElement >> width [
	^ realElement width
]
