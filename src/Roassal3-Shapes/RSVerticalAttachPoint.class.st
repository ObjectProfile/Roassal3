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
RSVerticalAttachPoint >> basicEndingPointOf: aLine [
	^ self
		positionFor: aLine to
		in: aLine
		point: aLine to encompassingRectangle topCenter + (0@endOffset)
]

{ #category : #'public - hooks' }
RSVerticalAttachPoint >> basicStartingPointOf: aLine [
	^ self
		positionFor: aLine from
		in: aLine
		point: aLine from encompassingRectangle bottomCenter + (0@startOffset)
]
