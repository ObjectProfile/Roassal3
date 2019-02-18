"
My subclasses has an extent
"
Class {
	#name : #TSBoundingShape,
	#superclass : #TSShape,
	#instVars : [
		'width',
		'height'
	],
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #accessing }
TSBoundingShape >> encompassingRectangle [ 
	^ Rectangle center: self position extent: width@height
]

{ #category : #accessing }
TSBoundingShape >> extent [
	^ width @ height
]

{ #category : #accessing }
TSBoundingShape >> extent: aPoint [
	width := aPoint x.
	height := aPoint y.
	path := nil.
]

{ #category : #initialization }
TSBoundingShape >> initialize [
	super initialize.
	width := height := 0.
]

{ #category : #accessing }
TSBoundingShape >> size: anInteger [
	self extent: anInteger asPoint
]
