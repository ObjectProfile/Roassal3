Class {
	#name : #TSAbstractControPointsLine,
	#superclass : #TSAbstractLine,
	#instVars : [
		'controlPoints'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #accessing }
TSAbstractControPointsLine >> controlPoints [
	^ controlPoints ifNil: [ #() ].
]

{ #category : #accessing }
TSAbstractControPointsLine >> controlPoints: anArrayOfPoints [
	controlPoints := anArrayOfPoints.
	self resetPath.
]

{ #category : #accessing }
TSAbstractControPointsLine >> endPoint [
	^ self controlPoints last
]

{ #category : #accessing }
TSAbstractControPointsLine >> endPoint: aPoint [
	self controlPoints 
		at: self controlPoints size
		put: aPoint.
	self resetPath.
]

{ #category : #testing }
TSAbstractControPointsLine >> isControlPointsLine [
	^ true
]

{ #category : #accessing }
TSAbstractControPointsLine >> startPoint [
	^ self controlPoints first
]

{ #category : #accessing }
TSAbstractControPointsLine >> startPoint: aPoint [
	self controlPoints at: 1 put: aPoint.
	self resetPath.
]
