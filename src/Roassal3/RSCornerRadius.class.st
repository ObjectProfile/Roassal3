"
I have information about the corner radius and methods to create it
"
Class {
	#name : #RSCornerRadius,
	#superclass : #RSObject,
	#instVars : [
		'bottomRight',
		'bottomLeft',
		'topRight',
		'topLeft'
	],
	#category : #'Roassal3-Border'
}

{ #category : #accessing }
RSCornerRadius >> bottom: aNumber [
	bottomLeft := bottomRight := aNumber
]

{ #category : #accessing }
RSCornerRadius >> bottomLeft [ 
	^ bottomLeft
]

{ #category : #accessing }
RSCornerRadius >> bottomLeft: aNumber [
	bottomLeft := aNumber
]

{ #category : #accessing }
RSCornerRadius >> bottomRight [
	^ bottomRight 
]

{ #category : #accessing }
RSCornerRadius >> bottomRight: aNumber [
	bottomRight := aNumber
]

{ #category : #initialization }
RSCornerRadius >> initialize [
	super initialize.
	self radius: 0.
]

{ #category : #accessing }
RSCornerRadius >> left: aNumber [
	topLeft := bottomLeft := aNumber
]

{ #category : #accessing }
RSCornerRadius >> max [
	^ topLeft max: (topRight max: (bottomLeft max: bottomRight))
]

{ #category : #accessing }
RSCornerRadius >> min [
	^ topLeft min: (topRight min: (bottomLeft min: bottomRight))
]

{ #category : #accessing }
RSCornerRadius >> radius: aNumber [
	topLeft := topRight := bottomLeft := bottomRight := aNumber
]

{ #category : #accessing }
RSCornerRadius >> right: aNumber [
	topRight := bottomRight := aNumber
]

{ #category : #accessing }
RSCornerRadius >> top: aNumber [
	topLeft := topRight := aNumber
]

{ #category : #accessing }
RSCornerRadius >> topLeft [
	^ topLeft 
]

{ #category : #accessing }
RSCornerRadius >> topLeft: aNumber [
	topLeft := aNumber
]

{ #category : #accessing }
RSCornerRadius >> topRight [
	^ topRight
]

{ #category : #accessing }
RSCornerRadius >> topRight: aNumber [
	topRight := aNumber
]
