"
TODO
"
Class {
	#name : #TSCircleLayout,
	#superclass : #TSAbstractCircleLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'instance creation' }
TSCircleLayout class >> scaleBy: aNumber [
	
	^self new scaleBy: aNumber
]

{ #category : #hook }
TSCircleLayout >> doExecute: elements [
	| angleIncrement angle rad center |
	rad := self computeRadiusFor: elements.
	center := Point x: rad y: rad.
	angleIncrement := self computeIncrementalAngleFor: elements.
	angle := self initialAngle.
	elements
		do: [ :each | 
			| point |
			point := center + (Point r: rad theta: angle).
			angle := angle + angleIncrement.
			translator translateTopLeftOf: each to: point.
			self step ]
]
