Class {
	#name : #TSCamera,
	#superclass : #TSObject,
	#instVars : [
		'position',
		'height',
		'scale',
		'canvas'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #accessing }
TSCamera >> canvas [
	^ canvas
]

{ #category : #accessing }
TSCamera >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #initialization }
TSCamera >> initialize [
	super initialize.
	position := 0 @ 0.
	scale := 1.0001.
]

{ #category : #accessing }
TSCamera >> position [
	^ position 
]

{ #category : #accessing }
TSCamera >> position: aPoint [
	^position 
]

{ #category : #accessing }
TSCamera >> scale [
	^ scale
]

{ #category : #accessing }
TSCamera >> scale: aNumber [
	^ scale
]
