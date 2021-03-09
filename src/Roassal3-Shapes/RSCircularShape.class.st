"
Each of my subclasses describes a circular shape
"
Class {
	#name : #RSCircularShape,
	#superclass : #RSBoundingShape,
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #testing }
RSCircularShape class >> isAbstract [
	^ self == RSCircularShape
]

{ #category : #accessing }
RSCircularShape class >> size: anInteger [
	"Create a new circular shape with a given size"
	^ self new size: anInteger
]
