"
This is the default coordinate system in roassal, it puts the origin in the center(x) middle(y) of the window. that means that `0@0` is there 
"
Class {
	#name : 'RSCenterMiddleCoordinates',
	#superclass : 'RSCoordinates',
	#category : 'Roassal-Camera',
	#package : 'Roassal',
	#tag : 'Camera'
}

{ #category : 'public' }
RSCenterMiddleCoordinates >> gapDistance: anRSCamera [
	^ anRSCamera canvas extent / 2
]
