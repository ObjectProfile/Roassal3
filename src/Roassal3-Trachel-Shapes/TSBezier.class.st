"
TSBezier represents a bezier lines of one and 2 control points
"
Class {
	#name : #TSBezier,
	#superclass : #TSAbstractControPointsLine,
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSBezier >> buildPathOn: visitor [
	visitor buildBezierPath: self.
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
TSBezier >> startPoint [
	^ controlPoints first
]
