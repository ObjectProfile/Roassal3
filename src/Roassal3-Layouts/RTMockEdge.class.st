Class {
	#name : #RTMockEdge,
	#superclass : #RSObject,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Roassal3-Layouts'
}

{ #category : #accessing }
RTMockEdge >> from [
	^ from
]

{ #category : #accessing }
RTMockEdge >> from: aMockElement [
	from := aMockElement
]

{ #category : #accessing }
RTMockEdge >> to [
	^ to
]

{ #category : #accessing }
RTMockEdge >> to: aMockElement [
	to := aMockElement
]
