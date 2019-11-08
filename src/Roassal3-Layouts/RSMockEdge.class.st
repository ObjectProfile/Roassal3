"
TODO
"
Class {
	#name : #RSMockEdge,
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
RSMockEdge >> from [
	^ from
]

{ #category : #accessing }
RSMockEdge >> from: aMockElement [
	from := aMockElement
]

{ #category : #accessing }
RSMockEdge >> length [
	^ length
]

{ #category : #accessing }
RSMockEdge >> length: aNumber [
	length := aNumber
]

{ #category : #accessing }
RSMockEdge >> realEdge [
	^ realEdge
]

{ #category : #accessing }
RSMockEdge >> realEdge: anObject [
	realEdge := anObject
]

{ #category : #accessing }
RSMockEdge >> strength [ 
	^ strength
]

{ #category : #accessing }
RSMockEdge >> strength: aNumber [
	strength := aNumber
]

{ #category : #accessing }
RSMockEdge >> to [
	^ to
]

{ #category : #accessing }
RSMockEdge >> to: aMockElement [
	to := aMockElement
]
