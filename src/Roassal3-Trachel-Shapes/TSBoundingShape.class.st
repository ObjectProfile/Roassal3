"
My subclasses has an extent and a transformation matrix
"
Class {
	#name : #TSBoundingShape,
	#superclass : #TSShape,
	#instVars : [
		'extent',
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
	^ Rectangle rsCenter: 0@0 extent: extent
]

{ #category : #accessing }
TSBoundingShape >> encompassingRectangle [ 
	^ Rectangle rsCenter: self position extent: extent.
]

{ #category : #accessing }
TSBoundingShape >> extent [
	^ extent
]

{ #category : #accessing }
TSBoundingShape >> extent: aPoint [
	| oldExtent |
	extent = aPoint ifTrue: [ ^ self ].
	oldExtent := extent.
	extent := aPoint.
	self resetPath.
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
	extent := 0@0
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
	aBlock value: matrix
]

{ #category : #matrix }
TSBoundingShape >> position [ 
	^ matrix translation
]

{ #category : #matrix }
TSBoundingShape >> position: aPoint [
	matrix translation: aPoint
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
TSBoundingShape >> shapes [
	"only TSComposite can use shapes "
	^ nil
]

{ #category : #accessing }
TSBoundingShape >> size: anInteger [
	self extent: anInteger asPoint
]

{ #category : #accessing }
TSBoundingShape >> translateBy: delta [
	self translateTo: self position + delta.
	
]

{ #category : #accessing }
TSBoundingShape >> translateTo: aPoint [
	| oldPosition |
	oldPosition := self position.
	oldPosition = aPoint ifTrue: [ ^ self ].
	self position: aPoint.
	self announce: [TSPositionChangedEvent new 
		shape: self; 
		oldPosition: oldPosition;
		newPosition: aPoint ].

]

{ #category : #accessing }
TSBoundingShape >> width: aNumber [
	self extent: aNumber @ self extent y
]
