"
Circle layout puts elements arround a circle. I use variables defined in my super class
"
Class {
	#name : #RSCircleLayout,
	#superclass : #RSAbstractCircleLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'instance creation' }
RSCircleLayout class >> scaleBy: aNumber [

	^self new scaleBy: aNumber
]

{ #category : #hook }
RSCircleLayout >> doExecute: elements [
	| angle rad angleInc center |
	rad := self computeRadiusFor: elements.
	angleInc := self computeIncrementalAngleFor: elements.
	angle := self initialAngle.
	center := self computeCenter: rad.
	elements do: [ :each |
		| point |
		point := center + (Point r: rad theta: angle).
		angle := angle + angleInc.
		translator translateTopLeftOf: each to: point.
	]
]
