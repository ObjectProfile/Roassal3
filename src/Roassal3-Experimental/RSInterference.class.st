"
TODO
"
Class {
	#name : #RSInterference,
	#superclass : #RSObject,
	#instVars : [
		'position',
		'mode',
		'radius'
	],
	#category : #'Roassal3-Experimental-Force'
}

{ #category : #accessing }
RSInterference >> color: aColor [
]

{ #category : #initialization }
RSInterference >> initialize [
	| r |
	super initialize.
	r := SharedRandom globalGenerator.
	self mode: (r next < 0.5
		ifTrue: [ #attract ]
		ifFalse: [ #reject ]).
	self radius: r next * 300
]

{ #category : #accessing }
RSInterference >> mode [
	^ mode
]

{ #category : #accessing }
RSInterference >> mode: aSymbol [
	mode := aSymbol
]

{ #category : #accessing }
RSInterference >> position [
	^ position
]

{ #category : #accessing }
RSInterference >> position: aPoint [
	position := aPoint
]

{ #category : #initialization }
RSInterference >> radius [
	^ radius
]

{ #category : #initialization }
RSInterference >> radius: aNumber [
	radius := aNumber
]
