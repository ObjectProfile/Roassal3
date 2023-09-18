"
RSWeightedCircleLayout is a circle layout that gives more space to big elements and fewer space to small elements.
"
Class {
	#name : #RSWeightedCircleLayout,
	#superclass : #RSAbstractWeightedCircleLayout,
	#category : #'Roassal-Layouts-Circle'
}

{ #category : #hook }
RSWeightedCircleLayout >> doExecute: elements [
	| angle rad center angleInc weightSum size |
	rad := self computeRadiusFor: elements.
	center := self computeCenter: rad.
	angleInc := self computeIncrementalAngleFor: elements.
	angle := self initialAngle.
	weightSum := self weightSum: elements.
	size := elements size.
	elements do: [ :each |
		| point fctr |
		"The factor weighs the angleIncrement"
		"The angle is increased by half of the total increment,
		then the point is set, and then it's increased by the other half"
		"This is to consider both last and next elements weights"
		fctr := size * each height / weightSum.
		angle := angle + (angleInc * (fctr/2)).
		point := center + (Point r: rad theta: angle).
		angle := angle + (angleInc*(fctr/2)).
		translator translate: each to: point ]
]
