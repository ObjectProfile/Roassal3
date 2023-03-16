"
This layout finds the shape with most connexions then it uses a circular layout with the rest.
Then it puts the shape with most connexion in the center.

"
Class {
	#name : #RSCircularAroundAVertexLayout,
	#superclass : #RSAbstractCircleLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSCircularAroundAVertexLayout >> doExecute: shapes [
	| centerShape rad circleLayout |
	centerShape := self findCenterIn: shapes.
	shapes remove: centerShape.

	(circleLayout := RSEquidistantCircleLayout new)
		initialAngle: self initialAngle;
		radius: (self computeRadiusFor: shapes);
		on: shapes.
	rad := circleLayout computeRadiusFor: shapes.
	centerShape position: rad@rad
]

{ #category : #utilities }
RSCircularAroundAVertexLayout >> findCenterIn: aCollection [
	| max currentSize center |
	max := 0.
	center := nil.
	aCollection do: [ :each |
		currentSize := each connectedLines size.
		currentSize > max ifTrue: [
			max := currentSize.
			center := each ] ].
	^ center
]
