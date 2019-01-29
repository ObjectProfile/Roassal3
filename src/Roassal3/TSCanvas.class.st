Class {
	#name : #TSCanvas,
	#superclass : #TSObject,
	#instVars : [
		'shapes',
		'fixedShapes',
		'camera',
		'renderTree'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #adding }
TSCanvas >> addShape: aShape [
	"Add a shape to the canvas. The shape may be fixed or not"
	aShape isFixed 
		ifTrue: [ fixedShapes add: aShape ]
		ifFalse: [ shapes add: aShape ]
]

{ #category : #initialization }
TSCanvas >> initialize [
	super initialize.
	shapes := OrderedCollection new.
	fixedShapes := OrderedCollection new
]

{ #category : #accessing }
TSCanvas >> numberOfFixedShapes [
	"Return the number of fixed shapes"
	^ fixedShapes size
]

{ #category : #accessing }
TSCanvas >> numberOfShapes [
	"Return the number of non-fixed shapes"
	^ shapes size
]
