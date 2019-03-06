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
	^ controlPoints
]

{ #category : #accessing }
TSAbstractControPointsLine >> controlPoints: anArrayOfPoints [
	self
		assert: anArrayOfPoints notNil 
		description: 'The argument can not be nil';
		assert: (anArrayOfPoints size between: 2 and: 4)
		description: 'The array size must be between 2 and 4 points'.
	controlPoints := anArrayOfPoints. 
]
