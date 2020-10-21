"
My subclasses has an extent and a transformation matrix
"
Class {
	#name : #RSBoundingShape,
	#superclass : #RSShape,
	#traits : 'RSTPositionable',
	#classTraits : 'RSTPositionable classTrait',
	#instVars : [
		'baseRectangle',
		'matrix',
		'connectedEdges',
		'shouldUpdateEdges'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #testing }
RSBoundingShape class >> isAbstract [
	^ self == RSBoundingShape
]

{ #category : #visiting }
RSBoundingShape >> accept: visitor [
	visitor visitBoundingShape: self
]

{ #category : #edges }
RSBoundingShape >> addConnectedEdge: anEdge [
	self assert: anEdge isEdge.
	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : #accessing }
RSBoundingShape >> baseRectangle [
	^ baseRectangle
]

{ #category : #matrix }
RSBoundingShape >> basicTranslateBy: delta [
	self updateEdgesOFF.
	self position: self position + delta.
	self updateEdgesON.
]

{ #category : #accessing }
RSBoundingShape >> computeEncompassingRectangle [
	^ self computeEncompassingRectangleFor: self baseRectangle.
	
]

{ #category : #accessing }
RSBoundingShape >> computeEncompassingRectangleFor: rect [ 
	^ self computeEncompassingRectangleFor: rect matrix: self matrix
]

{ #category : #accessing }
RSBoundingShape >> computeEncompassingRectangleFor: rect matrix: aMatrix [
	| points |
	points := #(topLeft topRight bottomRight bottomLeft)
		collect: [ :s | aMatrix transform: (s value: rect) ].
	^ Rectangle encompassing: points.
	
]

{ #category : #edges }
RSBoundingShape >> connectedEdges [
	"Return the list of connected egdes (i.e., incoming and outgoing edges)"
	connectedEdges ifNil: [ connectedEdges := RSGroup new ].
	^ connectedEdges
]

{ #category : #accessing }
RSBoundingShape >> extent: aPoint [
	| oldExtent extent |
	extent := baseRectangle extent.
	extent = aPoint ifTrue: [ ^ self ].
	self assert: aPoint isPoint.
	oldExtent := extent.
	baseRectangle := Rectangle floatCenter: 0@0 extent: aPoint.
	self resetBBox; resetPath.
	self announce: [ RSExtentChangedEvent new 
		shape: self;
		oldExtent: oldExtent;
		newExtent: extent ]
]

{ #category : #initialization }
RSBoundingShape >> fromRectangle: aRectangle [
	"Set the position and extent of the shape, using a rectangle as argument.
	For example:
	
-=-=-=-=-=-=-=-=-=	
c := RSCanvas new.
box := RSBox new.
box fromRectangle: (10 @ 10 corner: 50 @ 40).
c add: box.
c
-=-=-=-=-=-=-=-=-=
"
	self 
		translateTo: aRectangle floatCenter;
		extent: aRectangle extent
]

{ #category : #geometry }
RSBoundingShape >> geometry [
	| rect e |
	rect := self encompassingRectangle.
	e := rect extent.
	e = (0@0) ifTrue: [ ^ rect floatCenter asGPoint ].
	^ GRectangle
		origin: rect origin 
		corner: rect corner
]

{ #category : #matrix }
RSBoundingShape >> globalMatrix [
	^ parent globalMatrix multiplyBy: matrix.
]

{ #category : #testing }
RSBoundingShape >> hasEdges [
	"Return true if the shape has any outgoing or incoming edge"
	^ connectedEdges notNil
]

{ #category : #accessing }
RSBoundingShape >> height: aNumber [
	self extent: self extent x @ aNumber
]

{ #category : #testing }
RSBoundingShape >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix rsInverseTransform: aPoint.
	^ self baseRectangle containsPoint: invertedPoint.
]

{ #category : #edges }
RSBoundingShape >> incomingEdges [
	"Return the list of incoming edges from the node"
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e to == self ]
]

{ #category : #initialization }
RSBoundingShape >> initialize [
	super initialize.
	self initializeMatrix; updateEdgesON.
	baseRectangle := 0@0 corner: 0@0.
]

{ #category : #initialization }
RSBoundingShape >> initializeMatrix [
	matrix := AthensAffineTransform new
]

{ #category : #edges }
RSBoundingShape >> isDirectlyConnectedTo: aShape [
	connectedEdges ifNil: [ ^ false ].
	^ connectedEdges anySatisfy: [ :edge | edge to == aShape ]
]

{ #category : #testing }
RSBoundingShape >> isNode [
	^ true
]

{ #category : #matrix }
RSBoundingShape >> loadIdentity [
	matrix loadIdentity
]

{ #category : #matrix }
RSBoundingShape >> matrix [
	^ matrix
]

{ #category : #matrix }
RSBoundingShape >> matrix: aMatrix [
	matrix := aMatrix
]

{ #category : #matrix }
RSBoundingShape >> matrixDo: aBlock [
	aBlock value: matrix.
	self resetBBox.
]

{ #category : #edges }
RSBoundingShape >> outgoingEdges [
	"Return the list of outgoing edges from the node"
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e from == self ]
]

{ #category : #matrix }
RSBoundingShape >> position [ 
	^ matrix translation
]

{ #category : #matrix }
RSBoundingShape >> position: aPoint [
	self 
		assert: (aPoint x isNaN | aPoint y isNaN) not
		description: 'you must provide a real point'.
	matrix translation: aPoint.
	self resetBBox.
	self updateConnectedEdges.
]

{ #category : #accessing }
RSBoundingShape >> positionInCanvas [
	^ self globalMatrix transform: 0@0.
]

{ #category : #copying }
RSBoundingShape >> postCopy [
	super postCopy.
	self matrix: self matrix copy
]

{ #category : #actions }
RSBoundingShape >> remove [
	parent ifNil: [ ^ self ].
	parent removeNode: self.
	self removeConnectedEdges.
	super remove
]

{ #category : #edges }
RSBoundingShape >> removeConnectedEdge: anEdge [
	[  anEdge isEdge ] assert.
	self connectedEdges remove: anEdge ifAbsent: [ ]
]

{ #category : #edges }
RSBoundingShape >> removeConnectedEdges [
	"Remove all the edges connected (incoming and outgoing)."
	self connectedEdges copy do: [ :edge | edge remove ]
]

{ #category : #adding }
RSBoundingShape >> renderOn: aCanvas [
	aCanvas addNode: self
]

{ #category : #matrix }
RSBoundingShape >> rotateByDegrees: angle [
	"Rotate the shape. Here is an exanmple:
-=-=-=
c := RSCanvas new.

polygon := RSPolygon new
		points: { 0 @ -50 . 50 @ 0 . -50 @ 0 };
		color: 'FFAE0B'.
polygon cornerRadii: 5.
polygon rotateByDegrees: -45.		

c add: polygon.
c	
-=-=-=
	"
	matrix rotateByDegrees: angle
]

{ #category : #matrix }
RSBoundingShape >> rotateByRadians: angle [
	"Rotate the shape. Here is an exanmple:
-=-=-=
c := RSCanvas new.
c add: (RSBox new
	size: 10;
	rotateByRadians: Float pi / 3;
	yourself).
c
-=-=-=
	"
	matrix rotateByRadians: angle
]

{ #category : #matrix }
RSBoundingShape >> scale [
	^ matrix scale
]

{ #category : #matrix }
RSBoundingShape >> scaleBy: scale [ 
	"Scale the shape. For example:

-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

polygon := RSPolygon new
		points: { 0 @ -50 . 50 @ 0 . -50 @ 0 };
		color: 'FFAE0B'.
polygon cornerRadii: 5.
polygon rotateByDegrees: -45.		
polygon scaleBy: 4.
c add: polygon.

c
-=-=-=-=-=-=-=-=-=
	"
	matrix scaleBy: scale
]

{ #category : #testing }
RSBoundingShape >> shouldUpdateEdges [
	^ shouldUpdateEdges and: [ connectedEdges notNil ]
]

{ #category : #accessing }
RSBoundingShape >> size: anInteger [
	self extent: anInteger asPoint
]

{ #category : #matrix }
RSBoundingShape >> transform: aPoint [
	"useful for attachpoints"
	^ matrix transform: aPoint
]

{ #category : #edges }
RSBoundingShape >> updateConnectedEdges [
	self shouldUpdateEdges
		ifFalse: [ ^ self ].
	self connectedEdges do: [ :edge | edge update ].
]

{ #category : #edges }
RSBoundingShape >> updateEdgesOFF [
	shouldUpdateEdges := false
]

{ #category : #edges }
RSBoundingShape >> updateEdgesON [
	shouldUpdateEdges := true
]

{ #category : #accessing }
RSBoundingShape >> width: aNumber [
	self extent: aNumber @ self extent y
]

{ #category : #matrix }
RSBoundingShape >> x: aNumber [
	"recibes a number"
	self position: aNumber @ self position y
]

{ #category : #matrix }
RSBoundingShape >> y: aNumber [
	"recibes a number"
	self position: self position x @ aNumber
]
