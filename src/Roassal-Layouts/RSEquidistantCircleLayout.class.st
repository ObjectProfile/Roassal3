"
`RSEquidistantCircleLayout` is a circle layout in which elements are equidistant from each other: the layout maintains the same distance between elements.
"
Class {
	#name : #RSEquidistantCircleLayout,
	#superclass : #RSAbstractWeightedCircleLayout,
	#category : #'Roassal-Layouts-Circle'
}

{ #category : #hook }
RSEquidistantCircleLayout >> computeSeparationFor: elements [
	"Compute the separation between each element, this separation will always be the same"
	| sep |
	sep := ((Float twoPi * (self computeRadiusFor: elements)) - (self weightSum: elements))/
	(elements size).
	^ sep
]

{ #category : #hook }
RSEquidistantCircleLayout >> doExecute: shapes [
	| angle rad center angleInc separation |
	rad := self computeRadiusFor: shapes.
	center := self computeCenter: rad.
	angle := self initialAngle.
	separation := self computeSeparationFor: shapes.
	shapes do: [ :each |
		| point height |
		"First, the angle is increased only by the angle given by the element radius (height/2),
		then the point is set, and then it's increased by the rest of the total increment"
		"This is to consider both last and next elements weights"
		height := each height.
		angle := angle + (height/(2*rad)).
		point := center + (Point r: rad theta: angle).
		angleInc := (height / 2 + separation)/rad.
		angle := angle + angleInc.
		translator translate: each to: point.
	]
]
