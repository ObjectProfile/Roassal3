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
		'matrix'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSBoundingShape >> accept: visitor [
	visitor visitBoundingShape: self
]

{ #category : #accessing }
TSBoundingShape >> baseRectangle [
	^ baseRectangle
]

{ #category : #accessing }
TSBoundingShape >> encompassingRectangle [ 
	| rect points |
	encompassingRectangle ifNotNil: [ ^ encompassingRectangle ].
	rect := self baseRectangle.
	points := #(topLeft topRight bottomRight bottomLeft)
		collect: [ :s | matrix transform: (s value: rect) ].
	rect := Rectangle encompassing: points.
	encompassingRectangle := rect.
	^ encompassingRectangle
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

{ #category : #initialization }
TSBoundingShape >> initialize [
	super initialize.
	self initializeMatrix.
	baseRectangle := 0@0 corner: 0@0.
]

{ #category : #initialization }
TSBoundingShape >> initializeMatrix [
	matrix := AthensAffineTransform new
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

{ #category : #matrix }
TSBoundingShape >> position [ 
	^ matrix translation
]

{ #category : #matrix }
TSBoundingShape >> position: aPoint [
	matrix translation: aPoint.
	self resetBBox.
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

{ #category : #accessing }
TSBoundingShape >> size: anInteger [
	self extent: anInteger asPoint
]

{ #category : #matrix }
TSBoundingShape >> transform: aPoint [
	"useful for attachpoints"
	^ matrix transform: aPoint
]

{ #category : #accessing }
TSBoundingShape >> width: aNumber [
	self extent: aNumber @ self extent y
]
