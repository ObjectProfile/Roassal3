"
RTWeightedCircleLayout is a circle layout that gives more space to big elements and fewer space to small elements.

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=
v := RSView new.
elements := (RSShapeBuilder circle size: 5; color: Color red; size: [:vv | vv * 4 ]) elementsOn: (1 to: 15).
v addAll: elements.
RSWeightedCircleLayout on: elements.
v @ RSControlsView.
v open
-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSWeightedCircleLayout,
	#superclass : #RSAbstractWeightedCircleLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSWeightedCircleLayout >> doExecute: elements [
	| angle rad center angleIncrement |
	rad := self computeRadiusFor: elements.
	center := Point x: rad y: rad.
	angleIncrement := self computeIncrementalAngleFor: elements.
	angle := self initialAngle.
	elements
		do: [ :each |
			| point fctr |
			"The factor weighs the angleIncrement"
			"The angle is increased by half of the total increment,
			then the point is set, and then it's increased by the other half"
			"This is to consider both last and next elements weights"
			fctr := (elements size)*(each height)/(self weightSum: elements).
			angle := angle + (angleIncrement*(fctr/2)).
			point := center + (Point r: rad theta: angle).
			angle := angle + (angleIncrement*(fctr/2)).
			translator translate: each to: point. ]
]
