"
It uses the center in the top left of the morph window
"
Class {
	#name : 'RSTopLeftCoordinates',
	#superclass : 'RSCoordinates',
	#category : 'Roassal-Camera',
	#package : 'Roassal',
	#tag : 'Camera'
}

{ #category : 'hooks' }
RSTopLeftCoordinates class >> gapToCenter: camera [
	^ camera canvas extent / 2
]

{ #category : 'public' }
RSTopLeftCoordinates class >> matrixFor: anRSCamera [
	^ anRSCamera matrix
]

{ #category : 'hooks' }
RSTopLeftCoordinates >> gapToCenter: camera [
	^ camera canvas extent / 2
]

{ #category : 'hooks' }
RSTopLeftCoordinates >> matrixFor: anRSCamera [
	^ anRSCamera matrix
]
