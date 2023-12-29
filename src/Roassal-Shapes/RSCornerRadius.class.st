"
I have information about the corner radius and methods to create it
"
Class {
	#name : 'RSCornerRadius',
	#superclass : 'RSObject',
	#instVars : [
		'bottomRight',
		'bottomLeft',
		'topRight',
		'topLeft'
	],
	#category : 'Roassal-Shapes-Border',
	#package : 'Roassal-Shapes',
	#tag : 'Border'
}

{ #category : 'accessing' }
RSCornerRadius >> bottom: aNumber [
	bottomLeft := bottomRight := aNumber
]

{ #category : 'accessing' }
RSCornerRadius >> bottomLeft [
	"Define the bottom left of the radius"
	^ bottomLeft
]

{ #category : 'accessing' }
RSCornerRadius >> bottomLeft: aNumber [
	bottomLeft := aNumber
]

{ #category : 'accessing' }
RSCornerRadius >> bottomRight [
	^ bottomRight
]

{ #category : 'accessing' }
RSCornerRadius >> bottomRight: aNumber [
	"Example of value could be 200"
	bottomRight := aNumber
]

{ #category : 'initialization' }
RSCornerRadius >> initialize [
	super initialize.
	self radius: 0
]

{ #category : 'transforming' }
RSCornerRadius >> interpolateTo: other at: t [
	"other is an instance of RSCornerRadius
	t is a float between 0 and 1"
	| |
	^ self class new
		topLeft: (self topLeft interpolateTo: other topLeft at: t);
		topRight: (self topRight interpolateTo: other topRight at: t);
		bottomLeft: (self bottomLeft interpolateTo: other bottomLeft at: t);
		bottomRight: (self bottomRight interpolateTo: other bottomRight at: t);
		yourself
]

{ #category : 'accessing' }
RSCornerRadius >> left: aNumber [
	topLeft := bottomLeft := aNumber
]

{ #category : 'accessing' }
RSCornerRadius >> max [
	^ topLeft max: (topRight max: (bottomLeft max: bottomRight))
]

{ #category : 'accessing' }
RSCornerRadius >> min [
	^ topLeft min: (topRight min: (bottomLeft min: bottomRight))
]

{ #category : 'accessing' }
RSCornerRadius >> radius: aNumber [
	topLeft := topRight := bottomLeft := bottomRight := aNumber
]

{ #category : 'accessing' }
RSCornerRadius >> right: aNumber [
	topRight := bottomRight := aNumber
]

{ #category : 'accessing' }
RSCornerRadius >> top: aNumber [
	topLeft := topRight := aNumber
]

{ #category : 'accessing' }
RSCornerRadius >> topLeft [
	^ topLeft
]

{ #category : 'accessing' }
RSCornerRadius >> topLeft: aNumber [
	topLeft := aNumber
]

{ #category : 'accessing' }
RSCornerRadius >> topRight [
	^ topRight
]

{ #category : 'accessing' }
RSCornerRadius >> topRight: aNumber [
	topRight := aNumber
]
