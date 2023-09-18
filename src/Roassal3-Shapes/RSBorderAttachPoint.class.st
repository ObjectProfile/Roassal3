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
RSBorderAttachPoint >> basicEndingPointOf: aLine [
	^ self
		basicPointFrom: aLine to
		to: aLine from
		of: aLine
		offset: endOffset
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicPointFrom: fromShape to: toShape of: aLine offset: aNumber [
	| source target line shift res vector unit |
	source := self geometryFor: fromShape edge: aLine.
	target := self geometryFor: toShape edge: aLine.
	shift := self offsetNormalFor: aLine.
	line := GLine through: source center and: target center.
	vector := line v2 asPoint - line v1 asPoint.
	vector := vector x @ vector y.
	unit := vector / (vector r max: 1).
	shift := vector normal * shift.
	aLine from = toShape
		ifTrue: [ shift := shift * -1 ].
	line := GLine
		through: source center asPoint + shift
		and: target center asPoint + shift.
	res := self borderPointFrom: source to: target via: line.
	^ res asPoint + (unit * aNumber)
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> basicStartingPointOf: aLine [
	^ self
		basicPointFrom: aLine from
		to: aLine to
		of: aLine
		offset: startOffset
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> borderPointFrom: aSource to: aTarget via: aLine [
	^ ((aLine intersectionsWith: aSource) detectMin: [ :p | p asPoint distanceTo: aLine v2 ])
		ifNil: [ aSource center ]
]

{ #category : #'public - hooks' }
RSBorderAttachPoint >> geometryFor: shape edge: aLine [
	| g commonParents matrix |
	g := shape geometry.
	(self hasParents: shape in: aLine)
		ifFalse: [ ^ g ].
	shape parent = aLine parent
		ifTrue: [ ^ g ].
	commonParents := self commonParents: shape in: aLine.
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
RSBorderAttachPoint >> offsetNormalFor: aLine [
	"Return the offset in case of multiple edges with the same starting and ending points"

	| indexOfEdge multipleLines |
	multipleLines := OrderedCollection new.
	multipleLines
		addAll:
			(aLine to connectedLines
				select: [ :e | e from == aLine from and: [ e to == aLine to ] ]).
	multipleLines
		addAll:
			(aLine to connectedLines
				select: [ :e | e to == aLine from and: [ e from == aLine to ] ]).
	multipleLines size <= 1
		ifTrue: [ ^ 0 @ 0 ].
	indexOfEdge := multipleLines indexOf: aLine.
	^ (indexOfEdge - 1 - (multipleLines size / 2)) * offset
]
