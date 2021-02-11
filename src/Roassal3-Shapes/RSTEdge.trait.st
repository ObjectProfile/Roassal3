"
My users have a line shape to interact with it. This trait has common methods to handle lines
"
Trait {
	#name : #RSTEdge,
	#category : #'Roassal3-Shapes-Graph'
}

{ #category : #'public - shape' }
RSTEdge >> addInteraction: anInteraction [
	self shape addInteraction: anInteraction
]

{ #category : #'public - shape' }
RSTEdge >> border [
	^ self shape border
]

{ #category : #'public - shape' }
RSTEdge >> border: aBorder [
	self shape border: aBorder
]

{ #category : #'public - shape' }
RSTEdge >> borderColor: aColor [
	self shape borderColor: aColor
]

{ #category : #'public - shape' }
RSTEdge >> capRound [
	self shape capRound
]

{ #category : #'public - shape' }
RSTEdge >> color: aColor [
	self shape color: aColor
]

{ #category : #'public - shape' }
RSTEdge >> controlPointsController [
	^ self shape controlPointsController
]

{ #category : #'public - shape' }
RSTEdge >> controlPointsController: aCPController [
	self shape controlPointsController: aCPController
]

{ #category : #'public - shape' }
RSTEdge >> cornerRadii: aNumber [
	^ self shape cornerRadii: aNumber
]

{ #category : #'public - shape' }
RSTEdge >> dashArray: anArray [
	^ self shape dashArray: anArray
]

{ #category : #'public - shape' }
RSTEdge >> dashed [
	self shape dashed
]

{ #category : #'public - shape' }
RSTEdge >> fmt: aString [
	self shape fmt: aString.
]

{ #category : #'public - shape' }
RSTEdge >> format: aString [
	
	"want more markers? submit a new issue in roassal3"
	| marker bs |
	marker := RSShapeFactory shapeFromString: aString.
	bs := RSStrokeStyle fromString: aString.
	marker ifNotNil: [ self shape marker: marker ].
	
]

{ #category : #'public - shape' }
RSTEdge >> joinRound [
	self shape joinRound
]

{ #category : #'public - shape' }
RSTEdge >> marker: aMarker [
	self shape marker: aMarker
]

{ #category : #'public - shape' }
RSTEdge >> markerEnd: aMarker [
	self shape markerEnd: aMarker
]

{ #category : #'public - shape' }
RSTEdge >> markerStart: aMarker [
	self shape markerStart: aMarker
]

{ #category : #'public - shape' }
RSTEdge >> noBorder [
	self shape noBorder
]

{ #category : #'public - shape' }
RSTEdge >> paint: aPaint [
	self shape paint: aPaint
]

{ #category : #'public - shape' }
RSTEdge >> shape [
	^ self explicitRequirement
]

{ #category : #'public - shape' }
RSTEdge >> shape: aRSAbstractLine [
	self explicitRequirement
]

{ #category : #'public - shape' }
RSTEdge >> width [
	^ self shape border width
]

{ #category : #'public - shape' }
RSTEdge >> width: aNumber [
	"Set the width of the line. For example:
	
-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

from := RSBox new size: 30; model: 'from'.
to := RSEllipse new size: 30; model: 'to'.

c add: from.
c add: to.

RSEdgeBuilder line
	canvas: c;
	width: 10;
	connectFrom: 'from' to: 'to'.


from @ RSDraggable.
to @ RSDraggable.

to translateTo: 50 @ 40.

c @ RSCanvasController
-=-=-=-=-=-=-=-=-=-=
	"
	self shape width: aNumber
]
