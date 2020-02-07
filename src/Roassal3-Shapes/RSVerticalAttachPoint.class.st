"
Vertical attach points between elements when drawing lines. Useful for (vertical) tree layout

-=-=-=-=
c := RSCanvas new.

shapes := (30 to: 50) collect: [ :nb |
	RSEllipse new size: nb; model: nb; yourself.
	 ] as: RSGroup.

c addAll: shapes.

lines := RSEdgeBuilder line
	canvas: c;
	connectFrom: 30 toAll: (31 to: 50).

lines do: [ :l | l attachPoint: (RSVerticalAttachPoint new) ].

RSGridLayout on: shapes. 
RSLocation new
	above;
	move: shapes first on: shapes allButFirst.
shapes @ RSDraggable.

c @ RSControlsCanvas
-=-=-=-=
"
Class {
	#name : #RSVerticalAttachPoint,
	#superclass : #RSOffsetAttachPoint,
	#category : #'Roassal3-Shapes-AttachPoint'
}

{ #category : #'public - hooks' }
RSVerticalAttachPoint >> basicEndingPointOf: anEdge [
	^ self 
		positionFor: anEdge to 
		in: anEdge 
		point: anEdge to encompassingRectangle topCenter + (0@endOffset)
]

{ #category : #'public - hooks' }
RSVerticalAttachPoint >> basicStartingPointOf: anEdge [
	^ self 
		positionFor: anEdge from
		in: anEdge 
		point: anEdge from encompassingRectangle bottomCenter + (0@startOffset)
]
