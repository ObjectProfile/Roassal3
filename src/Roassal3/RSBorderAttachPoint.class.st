"
I am an attach point that will end the line on the border of the end shapes.

Unline ContinuousAttachPoint & co. you don't need to care about what the end shape is, as long as it is one of the basic shapes.

Indirect way to use it:
-=-=-=-=
c := RSCanvas new.

shapes := (30 to: 50) collect: [ :nb |
	RSEllipse new size: nb; model: nb; yourself.
	 ] as: RSGroup.

c addAll: shapes.

RSEdgeBuilder line
	canvas: c;
	withBorderAttachPoint;
	connectFrom: 30 toAll: (31 to: 50).


RSGridLayout on: shapes. 
RSLocation new
	above;
	move: shapes first on: shapes allButFirst.
shapes @ RSDraggable.

c @ RSCanvasController
-=-=-=-=


Manual way to set an attach point:
-=-=-=-=
c := RSCanvas new.

shapes := (30 to: 50) collect: [ :nb |
	RSEllipse new size: nb; model: nb; yourself.
	 ] as: RSGroup.

c addAll: shapes.

lines := RSEdgeBuilder line
	canvas: c;
	connectFrom: 30 toAll: (31 to: 50).

lines do: [ :l | l attachPoint: (RSBorderAttachPoint new) ].

RSGridLayout on: shapes. 
RSLocation new
	above;
	move: shapes first on: shapes allButFirst.
shapes @ RSDraggable.

c @ RSCanvasController
-=-=-=-=
"
Class {
	#name : #RSBorderAttachPoint,
	#superclass : #RSOffsetAttachPoint,
	#instVars : [
		'offset'
	],
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicEndingPointOf: anEdge [
	^ self
		positionFor: anEdge to
		point: (self basicPointFrom: anEdge to to: anEdge from of: anEdge offset: endOffset)
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicPointFrom: fromShape to: toShape of: anEdge offset: aNumber [
	| source target line shift res vector unit |
	source := fromShape geometry.
	target := toShape geometry.
	shift := self offsetNormalFor: anEdge.
	line := GLineSegment from: source center to: target center.
	vector := line vector.
	unit := vector / (vector r max: 1).
	shift :=  vector normal * shift.
	anEdge from = toShape
		ifTrue: [ shift := shift * -1 ].
	line := GLineSegment from: source center + shift to: target center + shift.
	res := self borderPointFrom: source to: target via: line.
	^ res + (unit * aNumber).
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicStartingPointOf: anEdge [
	^ self
		positionFor: anEdge from 
		point: (self basicPointFrom: anEdge from to: anEdge to of: anEdge offset: startOffset)
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> borderPointFrom: aSource to: aTarget via: aLine [
	^ ((aLine intersect: aSource) detectMin: [ :p | p dist: aLine to ])
		ifNil: [ aSource center ]
]

{ #category : #initialization }
RSBorderAttachPoint >> initialize [
	super initialize.
	offset := 5
]

{ #category : #accessing }
RSBorderAttachPoint >> offset [
	^ offset
]

{ #category : #accessing }
RSBorderAttachPoint >> offset: aNumber [
	offset := aNumber
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> offsetNormalFor: anEdge [
	"Return the offset in case of multiple edges with the same starting and ending points"

	| indexOfEdge multipleEdges |
	multipleEdges := OrderedCollection new.
	multipleEdges
		addAll:
			(anEdge to connectedEdges
				select: [ :e | e from == anEdge from and: [ e to == anEdge to ] ]).
	multipleEdges
		addAll:
			(anEdge to connectedEdges
				select: [ :e | e to == anEdge from and: [ e from == anEdge to ] ]).
	multipleEdges size <= 1
		ifTrue: [ ^ 0 @ 0 ].
	indexOfEdge := multipleEdges indexOf: anEdge.
	^ (indexOfEdge - 1 - (multipleEdges size / 2)) * offset
]
