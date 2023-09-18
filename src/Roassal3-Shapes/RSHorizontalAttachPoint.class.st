"
Horizontal attach points between elements when drawing lines.  Useful for horizontal tree layout.

-=-=-=-=
c := RSCanvas new.

shapes := (30 to: 50) collect: [ :nb |
	RSEllipse new size: nb; model: nb; yourself.
	 ] as: RSGroup.

c addAll: shapes.

lines := RSEdgeBuilder line
	canvas: c;
	connectFrom: 30 toAll: (31 to: 50).

lines do: [ :l | l attachPoint: (RSHorizontalAttachPoint new) ].

RSGridLayout on: shapes. 
RSLocation new
	above;
	move: shapes first on: shapes allButFirst.
shapes @ RSDraggable.

c @ RSControlsCanvas
-=-=-=-=
"
Class {
	#name : #RSHorizontalAttachPoint,
	#superclass : #RSOffsetAttachPoint,
	#category : #'Roassal3-Shapes-AttachPoint'
}

{ #category : #'public - hooks' }
RSHorizontalAttachPoint >> basicEndingPointOf: aLine [
	^ self
		positionFor: aLine to
		in: aLine
		point: aLine to encompassingRectangle leftCenter + (endOffset@0)
]

{ #category : #'public - hooks' }
RSHorizontalAttachPoint >> basicStartingPointOf: aLine [
	^ self
		positionFor: aLine from
		in: aLine
		point: aLine from encompassingRectangle rightCenter + (startOffset@0)
]
