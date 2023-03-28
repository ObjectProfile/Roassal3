"
This layout finds the shape with most connexions then it uses a circular layout with the rest.
Then it puts the shape with most connexion in the center.

Users can select the center element using `centerIndex:`, if the center element is index in the collection of objects is not defined, then would be computed using the element with more connections
"
Class {
	#name : #RSCircularAroundAVertexLayout,
	#superclass : #RSAbstractCircleLayout,
	#instVars : [
		'centerIndex'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSCircularAroundAVertexLayout >> centerIndex [

	^ centerIndex
]

{ #category : #accessing }
RSCircularAroundAVertexLayout >> centerIndex: aNumber [
	"if center index is nil the would be computed"
	centerIndex := aNumber
]

{ #category : #hook }
RSCircularAroundAVertexLayout >> doExecute: shapes [
	| centerShape circleLayout rad |
	centerShape := self findCenterIn: shapes.
	shapes remove: centerShape.

	(circleLayout := RSEquidistantCircleLayout new)
		initialAngle: initialAngle;
		scaleFactor: scaleFactor;
		angleIncrement: angleIncrement;
		initialRadius: layoutRadius;
		centerPoint: centerPoint;
		on: shapes.
	rad := circleLayout computeRadiusFor: shapes.
	centerShape position: (circleLayout computeCenter: rad)
]

{ #category : #utilities }
RSCircularAroundAVertexLayout >> findCenterIn: aCollection [
	| max currentSize center |
	centerIndex ifNotNil: [ ^ aCollection at: centerIndex ].
	max := 0.
	center := nil.
	aCollection do: [ :each |
		currentSize := each connectedLines size.
		currentSize > max ifTrue: [
			max := currentSize.
			center := each ] ].
	^ center
]
