Class {
	#name : #TSBoundingShape,
	#superclass : #TSShape,
	#instVars : [
		'width',
		'height'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #accessing }
TSBoundingShape >> encompassingRectangle [ 
	^ Rectangle center: position extent: width@height
]

{ #category : #accessing }
TSBoundingShape >> extent: aPoint [
	width := aPoint x.
	height := aPoint y.
]

{ #category : #initialization }
TSBoundingShape >> initialize [
	super initialize.
	width := height := 0.
]
