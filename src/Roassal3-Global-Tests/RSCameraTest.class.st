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
