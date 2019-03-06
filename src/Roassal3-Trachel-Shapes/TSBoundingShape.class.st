"
My subclasses has an extent and a transformation matrix
"
Class {
	#name : #TSBoundingShape,
	#superclass : #TSShape,
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
	^ Rectangle center: self position extent: baseRectangle extent.
]

{ #category : #accessing }
TSBoundingShape >> extent [
	^ baseRectangle extent
]

{ #category : #accessing }
TSBoundingShape >> extent: aPoint [
	| oldExtent |
	oldExtent := baseRectangle extent.
	baseRectangle := Rectangle center: 0@0 extent: aPoint.
	self resetPath.
	
	oldExtent = aPoint ifTrue: [ ^ self  ].
	self announce: [ TSExtentShapeEvent new 
		shape: self;
		oldExtent: oldExtent ]
]

{ #category : #accessing }
TSBoundingShape >> height: aNumber [
	self extent: self extent x @ aNumber
]

{ #category : #testing }
TSBoundingShape >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	^ baseRectangle containsPoint: invertedPoint.
]

{ #category : #initialization }
TSBoundingShape >> initialize [
	super initialize.
	self initializeMatrix.
	baseRectangle := (0 @ 0) extent: (0 @ 0).
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
		canvas: aShape canvas.
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

{ #category : #accessing }
TSBoundingShape >> paintOn: visitor [
	^ paint
	
	
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
	self position: aPoint.
	oldPosition = aPoint ifTrue: [ ^ self ].
	self announce: [TSTranslationShapeEvent new 
		shape: self; 
		position: oldPosition;
		step: aPoint - oldPosition ].

]

{ #category : #accessing }
TSBoundingShape >> width: aNumber [
	self extent: aNumber @ self extent y
]
