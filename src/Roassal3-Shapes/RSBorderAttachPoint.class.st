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
	#category : #'Roassal3-Shapes-AttachPoint'
}

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicEndingPointOf: anEdge [
	^ self
		basicPointFrom: anEdge to
		to: anEdge from
		of: anEdge
		offset: endOffset
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicPointFrom: fromShape to: toShape of: anEdge offset: aNumber [
	| source target line shift res vector unit |
	source := self geometryFor: fromShape edge: anEdge.
	target := self geometryFor: toShape edge: anEdge.
	shift := self offsetNormalFor: anEdge.
	line := GLine through: source center and: target center.
	vector := line v2 asPoint - line v1 asPoint.
	vector := vector x @ vector y.
	unit := vector / (vector r max: 1).
	shift := vector normal * shift.
	anEdge from = toShape
		ifTrue: [ shift := shift * -1 ].
	line := GLine
		through: source center asPoint + shift
		and: target center asPoint + shift.
	res := self borderPointFrom: source to: target via: line.
	^ res asPoint + (unit * aNumber)
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicStartingPointOf: anEdge [
	^ self 
		basicPointFrom: anEdge from 
		to: anEdge to 
		of: anEdge 
		offset: startOffset
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> borderPointFrom: aSource to: aTarget via: aLine [
	^ ((aLine intersectionsWith: aSource) detectMin: [ :p | p asPoint distanceTo: aLine v2 ])
		ifNil: [ aSource center ]
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> geometryFor: shape edge: anEdge [
	| g commonParents matrix |
	g := shape geometry.
	(self hasParents: shape in: anEdge)
		ifFalse: [ ^ g ].
	shape parent = anEdge parent
		ifTrue: [ ^ g ].
	commonParents := self commonParents: shape in: anEdge.
	commonParents ifNil: [ ^ g ].
	matrix := self matrixFor: commonParents.
	g := g rsScaleWith: matrix.
	^ g
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
