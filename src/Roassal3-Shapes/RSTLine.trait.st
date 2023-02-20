"
My users have a line shape to interact with it. This trait has common methods to handle lines
"
Trait {
	#name : #RSTLine,
	#category : #'Roassal3-Shapes-Graph'
}

{ #category : #'public - shape' }
RSTLine >> addInteraction: anInteraction [
	self shape addInteraction: anInteraction
]

{ #category : #'public - shape' }
RSTLine >> border [
	^ self shape border
]

{ #category : #'public - shape' }
RSTLine >> border: aBorder [
	self shape border: aBorder
]

{ #category : #'public - shape' }
RSTLine >> borderColor: aColor [
	self shape borderColor: aColor
]

{ #category : #'public - shape' }
RSTLine >> capButt [
	self shape capButt
]

{ #category : #'public - shape' }
RSTLine >> capRound [
	self shape capRound
]

{ #category : #'public - shape' }
RSTLine >> capSquare [
	self shape capSquare
]

{ #category : #'public - shape' }
RSTLine >> color: aColor [
	self shape color: aColor
]

{ #category : #'public - shape' }
RSTLine >> controlPointsController [
	^ self shape controlPointsController
]

{ #category : #'public - shape' }
RSTLine >> controlPointsController: aCPController [
	self shape controlPointsController: aCPController
]

{ #category : #'public - shape' }
RSTLine >> cornerRadii: aNumber [
	^ self shape cornerRadii: aNumber
]

{ #category : #'public - shape' }
RSTLine >> dashArray: anArray [
	^ self shape dashArray: anArray
]

{ #category : #'public - shape' }
RSTLine >> dashed [
	self shape dashed
]

{ #category : #'public - shape' }
RSTLine >> fmt: aString [
	self shape fmt: aString
]

{ #category : #'public - shape' }
RSTLine >> format: aString [

	"want more markers? submit a new issue in roassal3"
	| marker bs |
	marker := RSShapeFactory shapeFromString: aString.
	bs := RSStrokeStyle fromString: aString.
	marker ifNotNil: [ self shape marker: marker ]
]

{ #category : #'public - shape' }
RSTLine >> joinBevel [
	self shape joinBevel
]

{ #category : #'public - shape' }
RSTLine >> joinMiter [
	self shape joinMiter
]

{ #category : #'public - shape' }
RSTLine >> joinRound [
	self shape joinRound
]

{ #category : #'public - shape' }
RSTLine >> marker: aMarker [
	self shape marker: aMarker
]

{ #category : #'public - shape' }
RSTLine >> markerEnd: aMarker [
	self shape markerEnd: aMarker
]

{ #category : #'public - shape' }
RSTLine >> markerStart: aMarker [
	self shape markerStart: aMarker
]

{ #category : #'public - shape' }
RSTLine >> markerStartEnd: aMarker [
	self shape markerStartEnd: aMarker
]

{ #category : #'public - shape' }
RSTLine >> noBorder [
	self shape noBorder
]

{ #category : #'public - shape' }
RSTLine >> paint: aPaint [
	self shape paint: aPaint
]

{ #category : #'public - shape' }
RSTLine >> shape [
	^ self explicitRequirement
]

{ #category : #'public - shape' }
RSTLine >> shape: aRSAbstractLine [
	self explicitRequirement
]

{ #category : #'public - shape' }
RSTLine >> width [
	^ self shape border width
]

{ #category : #'public - shape' }
RSTLine >> width: aNumber [
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
