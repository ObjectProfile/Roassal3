Class {
	#name : #RSCameraTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Core'
}

{ #category : #tests }
RSCameraTest >> testPosition [

	| c |
	c := RSCanvas new.
	c add: (RSEllipse new size: 30).
	c camera translateBy: 25 @ 15.
	self assert: c camera position equals: 25 @ 15
]

{ #category : #tests }
RSCameraTest >> testZoomToFit [
	| c c2 |
	c := RSCanvas new.
	c add: (RSEllipse new size: 30).
	c2 := c camera translateBy: 25 @ 15.
	c2 zoomToFit.
	self assert: c2 scale equals: 15.0
]
