Class {
	#name : #TSShape,
	#superclass : #TSObject,
	#instVars : [
		'position',
		'path',
		'isFixed',
		'color'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #accessing }
TSShape >> color [
	^ color 
]

{ #category : #accessing }
TSShape >> color: aColor [
	color := aColor
]

{ #category : #accessing }
TSShape >> encompassingRectangle [
	
]

{ #category : #testing }
TSShape >> includesPoint: aPoint [
	"Return true or false"
]

{ #category : #initialization }
TSShape >> initialize [
	super initialize.
	isFixed := false.
	position := 0@0.
	color := Color lightGray.
]

{ #category : #initialization }
TSShape >> isFixed [
	"Return true of false on whether the shape is fixed"
	^ isFixed
]

{ #category : #accessing }
TSShape >> path [
	^ path
]

{ #category : #accessing }
TSShape >> path: aPath [
	path := aPath
]

{ #category : #accessing }
TSShape >> position [ 
	^ position
]

{ #category : #accessing }
TSShape >> position: aPoint [
	position := aPoint.
	self resetPath.
]

{ #category : #initialization }
TSShape >> resetPath [
	path := nil
]
