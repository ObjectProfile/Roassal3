"
My subclasses has an extent and a transformation matrix
"
Class {
	#name : #TSBoundingShape,
	#superclass : #TSShape,
	#traits : 'TPositionable',
	#classTraits : 'TPositionable classTrait',
	#instVars : [
		'baseRectangle',
		'matrix',
		'connectedEdges',
		'shouldUpdateEdges'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #visiting }
TSBoundingShape >> accept: visitor [
	visitor visitBoundingShape: self
]

{ #category : #edges }
TSBoundingShape >> addConnectedEdge: anEdge [
	[ anEdge isEdge ] assert.
	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : #accessing }
TSBoundingShape >> baseRectangle [
	^ baseRectangle
]

{ #category : #accessing }
TSBoundingShape >> computeEncompassingRectangle [
	| rect points |
	rect := self baseRectangle.
	points := #(topLeft topRight bottomRight bottomLeft)
		collect: [ :s | matrix transform: (s value: rect) ].
	^ Rectangle encompassing: points.
	
]

{ #category : #edges }
TSBoundingShape >> connectedEdges [
	"Return the list of connected egdes (i.e., incoming and outgoing edges)"
	connectedEdges ifNil: [ connectedEdges := TSGroup new ].
	^ connectedEdges
]

{ #category : #accessing }
TSBoundingShape >> extent: aPoint [
	| oldExtent extent |
	extent := baseRectangle extent.
	extent = aPoint ifTrue: [ ^ self ].
	self assert: aPoint isPoint.
	oldExtent := extent.
	baseRectangle := Rectangle rsCenter: 0@0 extent: aPoint.
	self resetBBox; resetPath.
	self announce: [ TSExtentChangedEvent new 
		shape: self;
		oldExtent: oldExtent;
		newExtent: extent ]
]

{ #category : #geometry }
TSBoundingShape >> geometry [
	| rect |
	rect := self encompassingRectangle.
	^ GRectangle
		origin: rect origin 
		corner: rect corner
]

{ #category : #testing }
TSBoundingShape >> hasEdges [
	^ connectedEdges notNil
]

{ #category : #accessing }
TSBoundingShape >> height: aNumber [
	self extent: self extent x @ aNumber
]

{ #category : #testing }
TSBoundingShape >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	^ self baseRectangle containsPoint: invertedPoint.
]

{ #category : #edges }
TSBoundingShape >> incomingEdges [
	"Return the list of incoming edges from the node"
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e to == self ]
]

{ #category : #initialization }
TSBoundingShape >> initialize [
	super initialize.
	self initializeMatrix; updateEdgesON.
	baseRectangle := 0@0 corner: 0@0.
]

{ #category : #initialization }
TSBoundingShape >> initializeMatrix [
	matrix := AthensAffineTransform new
]

{ #category : #edges }
TSBoundingShape >> isDirectlyConnectedTo: anElement [
	connectedEdges ifNil: [ ^ false ].
	^ connectedEdges anySatisfy: [ :edge | edge to == anElement ]
]

{ #category : #actions }
TSBoundingShape >> loadBoundingShape: aShape [
	self 
		extent: aShape extent;
		matrix: aShape matrix;
		border: aShape border;
		paint: aShape paint;
		announcer: aShape announcer;
		parent: aShape parent.
]

{ #category : #actions }
TSBoundingShape >> loadShape: aShape [
	self loadBoundingShape: aShape.
]

{ #category : #matrix }
TSBoundingShape >> matrix [
	^ matrix
]

{ #category : #matrix }
TSBoundingShape >> matrix: aMatrix [
	matrix := aMatrix
]

{ #category : #matrix }
TSBoundingShape >> matrixDo: aBlock [
	aBlock value: matrix.
	self resetBBox.
]

{ #category : #edges }
TSBoundingShape >> outgoingEdges [
	"Return the list of outgoing edges from the node"
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e from == self ]
]

{ #category : #matrix }
TSBoundingShape >> position [ 
	^ matrix translation
]

{ #category : #matrix }
TSBoundingShape >> position: aPoint [
	matrix translation: aPoint.
	self resetBBox.
	self updateConnectedEdges.
]

{ #category : #copying }
TSBoundingShape >> postCopy [
	super postCopy.
	self matrix: self matrix copy
]

{ #category : #edges }
TSBoundingShape >> removeConnectedEdge: anEdge [
	[  anEdge isEdge ] assert.
	self connectedEdges remove: anEdge ifAbsent: [ ]
]

{ #category : #edges }
TSBoundingShape >> removeConnectedEdges [
	"Remove all the edges connected (incoming and outgoing)."
	self connectedEdges copy do: [ :edge | edge remove ]
]

{ #category : #adding }
TSBoundingShape >> renderOn: aCanvas [
	aCanvas addNode: self
]

{ #category : #matrix }
TSBoundingShape >> rotateByDegrees: angle [
	matrix rotateByDegrees: angle.
]

{ #category : #matrix }
TSBoundingShape >> scale [
	^ matrix scale
]

{ #category : #matrix }
TSBoundingShape >> scaleBy: scale [ 
	matrix scaleBy: scale
]

{ #category : #testing }
TSBoundingShape >> shouldUpdateEdges [
	^ shouldUpdateEdges and: [ connectedEdges notNil ]
]

{ #category : #accessing }
TSBoundingShape >> size: anInteger [
	self extent: anInteger asPoint
]

{ #category : #matrix }
TSBoundingShape >> transform: aPoint [
	"useful for attachpoints"
	^ matrix transform: aPoint
]

{ #category : #edges }
TSBoundingShape >> updateConnectedEdges [
	self shouldUpdateEdges ifFalse: [ ^ self ].
	self connectedEdges do: [ :edge | edge update ]
]

{ #category : #edges }
TSBoundingShape >> updateEdgesOFF [
	shouldUpdateEdges := false
]

{ #category : #edges }
TSBoundingShape >> updateEdgesON [
	shouldUpdateEdges := true
]

{ #category : #accessing }
TSBoundingShape >> width: aNumber [
	self extent: aNumber @ self extent y
]

{ #category : #matrix }
TSBoundingShape >> x: aNumber [
	"recibes a number"
	self position: aNumber @ self position y
]

{ #category : #matrix }
TSBoundingShape >> y: aNumber [
	"recibes a number"
	self position: self position x @ aNumber
]
