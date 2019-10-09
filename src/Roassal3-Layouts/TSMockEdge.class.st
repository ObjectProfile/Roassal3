"
TODO
"
Class {
	#name : #TSMockEdge,
	#superclass : #RSObject,
	#instVars : [
		'from',
		'to',
		'realEdge',
		'strength',
		'length'
	],
	#category : #'Roassal3-Layouts-Utils'
}

{ #category : #accessing }
TSMockEdge >> from [
	^ from
]

{ #category : #accessing }
TSMockEdge >> from: aMockElement [
	from := aMockElement
]

{ #category : #accessing }
TSMockEdge >> length [
	^ length
]

{ #category : #accessing }
TSMockEdge >> length: aNumber [
	length := aNumber
]

{ #category : #accessing }
TSMockEdge >> realEdge [
	^ realEdge
]

{ #category : #accessing }
TSMockEdge >> realEdge: anObject [
	realEdge := anObject
]

{ #category : #accessing }
TSMockEdge >> strength [ 
	^ strength
]

{ #category : #accessing }
TSMockEdge >> strength: aNumber [
	strength := aNumber
]

{ #category : #accessing }
TSMockEdge >> to [
	^ to
]

{ #category : #accessing }
TSMockEdge >> to: aMockElement [
	to := aMockElement
]
