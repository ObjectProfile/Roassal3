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
	| angleIncrement angle rad center |
	rad := self computeRadiusFor: elements.
	center := Point x: rad y: rad.
	angleIncrement := self computeIncrementalAngleFor: elements.
	angle := self initialAngle.
	elements do: [ :each |
		| point |
		point := center + (Point r: rad theta: angle).
		angle := angle + angleIncrement.
		translator translateTopLeftOf: each to: point.
	]
]
