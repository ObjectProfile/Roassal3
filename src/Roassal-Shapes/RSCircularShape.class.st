"
Each of my subclasses describes a circular shape
"
Class {
	#name : 'RSCircularShape',
	#superclass : 'RSBoundingShape',
	#category : 'Roassal-Shapes-Bounding',
	#package : 'Roassal-Shapes',
	#tag : 'Bounding'
}

{ #category : 'testing' }
RSCircularShape class >> isAbstract [
	^ self == RSCircularShape
]

{ #category : 'accessing' }
RSCircularShape class >> size: anInteger [
	"Create a new circular shape with a given size"
	^ self new size: anInteger
]

{ #category : 'accessing' }
RSCircularShape >> center [
	^ self position
]

{ #category : 'accessing' }
RSCircularShape >> center: aPoint [
	self position: aPoint
]
