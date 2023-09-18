"
I am a demo
"
Class {
	#name : #RSXmasFrontier,
	#superclass : #Object,
	#instVars : [
		'position',
		'velocity',
		'finished',
		'thickness'
	],
	#category : #'Roassal3-Experimental-Xmas2019'
}

{ #category : #accessing }
RSXmasFrontier >> finished [
	^ finished
]

{ #category : #accessing }
RSXmasFrontier >> finished: aBool [
	finished := aBool
]

{ #category : #initialization }
RSXmasFrontier >> initialize [
	super initialize.
	finished := false.
	thickness := SharedRandom globalGenerator rsNext: 10 and: 20
]

{ #category : #accessing }
RSXmasFrontier >> position [
	^ position
]

{ #category : #accessing }
RSXmasFrontier >> position: aPoint [
	position := aPoint
]

{ #category : #accessing }
RSXmasFrontier >> thickness [
	^ thickness
]

{ #category : #accessing }
RSXmasFrontier >> thickness: aNumber [
	thickness := aNumber
]

{ #category : #updating }
RSXmasFrontier >> update: factor [
	| rect r |
	rect := -10 asPoint corner: 510 asPoint.
	r := SharedRandom globalGenerator.
	((rect containsPoint: position) and: [thickness > factor] ) ifTrue: [
		| uncertain |
		velocity := velocity normalized * 0.8.
		uncertain := (r rsNext: -1 and: 1)@(r rsNext: -1 and: 1).
		uncertain := uncertain normalized * 0.2.
		velocity := velocity + uncertain.
		velocity := velocity * (r rsNext: 8 and: 15).
		position := position + velocity.
	] ifFalse: [
		finished := true
	 ]
]

{ #category : #accessing }
RSXmasFrontier >> velocity [
	^ velocity
]

{ #category : #accessing }
RSXmasFrontier >> velocity: aPoint [
	velocity := aPoint
]
