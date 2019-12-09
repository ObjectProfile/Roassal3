"
My subclasses has an extent and a transformation matrix
"
Class {
	#name : #RSBoundingShape,
	#superclass : #RSShape,
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
RSBoundingShape >> accept: visitor [
	visitor visitBoundingShape: self
]

{ #category : #edges }
RSBoundingShape >> addConnectedEdge: anEdge [
	[ anEdge isEdge ] assert.
	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : #accessing }
RSBoundingShape >> baseRectangle [
	^ baseRectangle
]

{ #category : #accessing }
RSBoundingShape >> computeEncompassingRectangle [
	| rect points |
	rect := self baseRectangle.
	points := #(topLeft topRight bottomRight bottomLeft)
		collect: [ :s | matrix transform: (s value: rect) ].
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
	baseRectangle := Rectangle rsCenter: 0@0 extent: aPoint.
	self resetBBox; resetPath.
	self announce: [ RSExtentChangedEvent new 
		shape: self;
		oldExtent: oldExtent;
		newExtent: extent ]
]

{ #category : #geometry }
RSBoundingShape >> geometry [
	| rect |
	rect := self encompassingRectangle.
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
	^ connectedEdges notNil
]

{ #category : #accessing }
RSBoundingShape >> height: aNumber [
	self extent: self extent x @ aNumber
]

{ #category : #testing }
RSBoundingShape >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
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
RSBoundingShape >> isDirectlyConnectedTo: anElement [
	connectedEdges ifNil: [ ^ false ].
	^ connectedEdges anySatisfy: [ :edge | edge to == anElement ]
]

{ #category : #testing }
RSBoundingShape >> isNode [
	^ true
]

{ #category : #actions }
RSBoundingShape >> loadBoundingShape: aShape [
	self 
		extent: aShape extent;
		matrix: aShape matrix;
		border: aShape border;
		paint: aShape paint;
		announcer: aShape announcer;
		parent: aShape parent.
]

{ #category : #actions }
RSBoundingShape >> loadShape: aShape [
	self loadBoundingShape: aShape.
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
	matrix rotateByDegrees: angle.
]

{ #category : #matrix }
RSBoundingShape >> scale [
	^ matrix scale
]

{ #category : #matrix }
RSBoundingShape >> scaleBy: scale [ 
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

{ #category : #actions }
RSBoundingShape >> translateTo: aPoint [
	| oldPosition |
	oldPosition := self position.
	oldPosition = aPoint ifTrue: [ ^ self ].
	self position: aPoint.
	self announce: [RSPositionChangedEvent new 
		shape: self; 
		oldPosition: oldPosition;
		newPosition: aPoint ].

]

{ #category : #edges }
RSBoundingShape >> updateConnectedEdges [
	self shouldUpdateEdges ifFalse: [ ^ self ].
	self connectedEdges do: [ :edge | edge update ]
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
