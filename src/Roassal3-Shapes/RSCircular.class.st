Class {
	#name : #RSCircular,
	#superclass : #RSBoundingShape,
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #accessing }
RSCircular class >> size: anInteger [
	"Create a new circular shape with a given size"
	^ self new size: anInteger
]
