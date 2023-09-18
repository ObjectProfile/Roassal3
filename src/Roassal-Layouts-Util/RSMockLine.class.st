"
TODO
"
Class {
	#name : #RSMockLine,
	#superclass : #RSObject,
	#instVars : [
		'from',
		'to',
		'strength',
		'length',
		'realLine'
	],
	#category : #'Roassal-Layouts-Util'
}

{ #category : #accessing }
RSMockLine >> from [
	^ from
]

{ #category : #accessing }
RSMockLine >> from: aMockElement [
	from := aMockElement
]

{ #category : #accessing }
RSMockLine >> length [
	^ length
]

{ #category : #accessing }
RSMockLine >> length: aNumber [
	length := aNumber
]

{ #category : #accessing }
RSMockLine >> realLine [
	^ realLine
]

{ #category : #accessing }
RSMockLine >> realLine: anRSLine [
	realLine := anRSLine
]

{ #category : #accessing }
RSMockLine >> strength [
	^ strength
]

{ #category : #accessing }
RSMockLine >> strength: aNumber [
	strength := aNumber
]

{ #category : #accessing }
RSMockLine >> to [
	^ to
]

{ #category : #accessing }
RSMockLine >> to: aMockElement [
	to := aMockElement
]
