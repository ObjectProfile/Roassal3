"
TODO
"
Class {
	#name : #RSMockEdge,
	#superclass : #RSObject,
	#instVars : [
		'from',
		'to',
		'realEdge'
	],
	#category : #'Roassal3-Layouts-Core'
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
RSMockEdge >> realEdge [
	^ realEdge
]

{ #category : #accessing }
RSMockEdge >> realEdge: anObject [
	realEdge := anObject
]

{ #category : #accessing }
RSMockEdge >> to [
	^ to
]

{ #category : #accessing }
RSMockEdge >> to: aMockElement [
	to := aMockElement
]
