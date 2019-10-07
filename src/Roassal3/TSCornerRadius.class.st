"
I have information about the corner radius and methods to create it
"
Class {
	#name : #TSCornerRadius,
	#superclass : #TSObject,
	#instVars : [
		'bottomRight',
		'bottomLeft',
		'topRight',
		'topLeft'
	],
	#category : #'Roassal3-Border'
}

{ #category : #accessing }
TSCornerRadius >> bottom: aNumber [
	bottomLeft := bottomRight := aNumber
]

{ #category : #accessing }
TSCornerRadius >> bottomLeft [ 
	^ bottomLeft
]

{ #category : #accessing }
TSCornerRadius >> bottomLeft: aNumber [
	bottomLeft := aNumber
]

{ #category : #accessing }
TSCornerRadius >> bottomRight [
	^ bottomRight 
]

{ #category : #accessing }
TSCornerRadius >> bottomRight: aNumber [
	bottomRight := aNumber
]

{ #category : #initialization }
TSCornerRadius >> initialize [
	super initialize.
	self radius: 0.
]

{ #category : #accessing }
TSCornerRadius >> left: aNumber [
	topLeft := bottomLeft := aNumber
]

{ #category : #accessing }
TSCornerRadius >> max [
	^ topLeft max: (topRight max: (bottomLeft max: bottomRight))
]

{ #category : #accessing }
TSCornerRadius >> min [
	^ topLeft min: (topRight min: (bottomLeft min: bottomRight))
]

{ #category : #accessing }
TSCornerRadius >> radius: aNumber [
	topLeft := topRight := bottomLeft := bottomRight := aNumber
]

{ #category : #accessing }
TSCornerRadius >> right: aNumber [
	topRight := bottomRight := aNumber
]

{ #category : #accessing }
TSCornerRadius >> top: aNumber [
	topLeft := topRight := aNumber
]

{ #category : #accessing }
TSCornerRadius >> topLeft [
	^ topLeft 
]

{ #category : #accessing }
TSCornerRadius >> topLeft: aNumber [
	topLeft := aNumber
]

{ #category : #accessing }
TSCornerRadius >> topRight [
	^ topRight
]

{ #category : #accessing }
TSCornerRadius >> topRight: aNumber [
	topRight := aNumber
]
