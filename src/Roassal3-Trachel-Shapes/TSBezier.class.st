"
TSBezier represents a bezier lines of one and 2 control points
"
Class {
	#name : #TSBezier,
	#superclass : #TSAbstractLine,
	#instVars : [
		'controlPoints'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #accessing }
TSBezier >> controlPoints [
	^ controlPoints
]

{ #category : #accessing }
TSBezier >> controlPoints: anArrayOfPoints [
	self
		assert: anArrayOfPoints notNil 
		description: 'The argument can not be nil';
		assert: (anArrayOfPoints size between: 2 and: 4)
		description: 'The array size must be between 2 and 4 points'.
	controlPoints := anArrayOfPoints. 
]

{ #category : #accessing }
TSBezier >> endPoint [
	^ controlPoints last
]

{ #category : #initialization }
TSBezier >> initialize [
	super initialize.
	controlPoints := { 0@0. 100@100 }.
]

{ #category : #accessing }
TSBezier >> pathFor: visitor [
	^ visitor pathOfBezier: self
]

{ #category : #accessing }
TSBezier >> startPoint [
	^ controlPoints first
]
