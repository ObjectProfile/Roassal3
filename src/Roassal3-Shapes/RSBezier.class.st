"
TSBezier represents a bezier lines of one and 2 control points
"
Class {
	#name : #RSBezier,
	#superclass : #RSAbstractControlPointsLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #visiting }
RSBezier >> buildPathOn: visitor [
	visitor buildBezierPath: self.
]

{ #category : #accessing }
RSBezier >> controlPoints: anArrayOfPoints [
	self
		assert: anArrayOfPoints notNil 
		description: 'The argument can not be nil';
		assert: (anArrayOfPoints size between: 2 and: 4)
		description: 'The array size must be between 2 and 4 points'.
	super controlPoints: anArrayOfPoints
]

{ #category : #initialization }
RSBezier >> initialize [
	super initialize.
	controlPoints := { 0@0. 100@100 }.
]
