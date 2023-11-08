Class {
	#name : 'RSCanvasOpening',
	#superclass : 'Object',
	#instVars : [
		'canvas',
		'window'
	],
	#category : 'Roassal-Mondrian-Connections',
	#package : 'Roassal-Mondrian',
	#tag : 'Connections'
}

{ #category : 'accessing' }
RSCanvasOpening >> canvas [
	^ canvas
]

{ #category : 'accessing' }
RSCanvasOpening >> canvas: anObject [
	canvas := anObject
]

{ #category : 'deleting' }
RSCanvasOpening >> deleteWindow [
	window ifNil: [ ^ self ].
	window delete
]

{ #category : 'accessing' }
RSCanvasOpening >> window [
	^ window
]

{ #category : 'accessing' }
RSCanvasOpening >> window: anObject [
	window := anObject
]
