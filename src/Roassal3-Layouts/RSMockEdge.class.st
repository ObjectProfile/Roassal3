"
TODO
"
Class {
	#name : #RSMockEdge,
	#superclass : #RSObject,
	#instVars : [
		'from',
		'to'
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
RSMockEdge >> to [
	^ to
]

{ #category : #accessing }
RSMockEdge >> to: aMockElement [
	to := aMockElement
]
