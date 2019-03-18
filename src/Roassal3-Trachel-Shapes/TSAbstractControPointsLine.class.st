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

{ #category : #testing }
TSAbstractControPointsLine >> isControlPointsLine [
	^ true
]
