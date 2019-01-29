Class {
	#name : #TSShape,
	#superclass : #TSObject,
	#instVars : [
		'position',
		'path',
		'isFixed'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #testing }
TSShape >> includesPoint: aPoint [
	"Return true or false"
]

{ #category : #initialization }
TSShape >> initialize [
	super initialize.
	isFixed := false
]

{ #category : #initialization }
TSShape >> isFixed [
	"Return true of false on whether the shape is fixed"
	^ isFixed
]
